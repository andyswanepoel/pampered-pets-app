class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]
  before_action :set_pets, only: %i[ new edit ]
  before_action :set_providers, only: %i[ new edit ]

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
  end


  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Current.user.bookings.build(booking_params.except(:pet_id))
    if @booking.save
      @booking.pets << Pet.where(id: booking_params[:pet_id]) if booking_params[:pet_id].present?
      BookingMailer.with(user: Current.user, pet_ids: booking_params[:pet_id], start_date: booking_params[:start_date], end_date: booking_params[:end_date]).pending_booking.deliver_later
      redirect_to bookings_path, notice: "Booking was successfully created."
    else
      set_pets
      set_providers
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    @booking.pets = Pet.where(id: booking_params[:pet_id]) if booking_params[:pet_id].present?
    respond_to do |format|
      if @booking.update(booking_params.except(:pet_id))
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

    def set_pets
      @pets = Current.user.pets
    end

    def set_providers
      @providers = User.includes(:roles).where(roles: { name: "provider" })
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:provider_id, :service_type, :start_date, :end_date, pet_id: [])
    end
end
