class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @pets = Current.user.pets
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    pet_ids = booking_params[:pet_id]

    begin
      ActiveRecord::Base.transaction do
        pet_ids.each do |pet_id|
          booking = Booking.new(pet_id: pet_id, **booking_params.except(:pet_id))
          unless booking.save
            puts "Error saving booking: #{booking.errors.full_messages.join(', ')}"
            raise ActiveRecord::Rollback, booking.errors.full_messages.join(", ") # Pass errors
          end
        end
      end

      BookingMailer.with(user: Current.user, pet_ids: pet_ids, start_date: booking_params[:start_date], end_date: booking_params[:end_date]).pending_booking.deliver_later

      redirect_to bookings_path, notice: "Booking was successfully created."

    rescue ActiveRecord::Rollback => e
      @pets = Current.user.pets
      render :new, status: :unprocessable_entity,  alert: "There was an issue creating your bookings: #{e}"
    rescue StandardError => e
      @pets = Current.user.pets
      render :new, status: :unprocessable_entity, alert: "There was an unexpected error: #{e.message}"
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy!

    respond_to do |format|
      format.html { redirect_to bookings_path, status: :see_other, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:start_date, :end_date, pet_id: [])
    end
end
