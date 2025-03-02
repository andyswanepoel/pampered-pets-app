class PetsController < ApplicationController
  before_action :set_pet, only: %i[ show edit update destroy ]
  before_action :set_pettable_types, only: %i[ new ]

  PETTABLE_PARAMS = {
    "Dog" => [ :breed, :activity_level ],
    "Cat" => [ :environment ]
  }.freeze

  # GET /pets or /pets.json
  def index
    @pets = Current.user.pets.includes(:pettable)
  end

  # GET /pets/1 or /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets or /pets.json
  def create
    pettable = case pet_params[:pettable_type]
    when "Dog"
      Dog.new(pet_params[:pettable_params])
    when "Cat"
      Cat.new(pet_params[:pettable_params])
    else
      nil
    end

    if pettable&.save
       @pet = Current.user.pets.build(pettable_id: pettable.id, **pet_params.except(:pettable_params))
      if @pet.save
        redirect_to @pet, notice: "Pet created successfully!"
      else
        render :new
      end
    else
      flash[:alert] = "Invalid pet details."
      render :new
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: "Pet was successfully updated." }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet.destroy!

    respond_to do |format|
      format.html { redirect_to pets_path, status: :see_other, notice: "Pet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params.expect(:id))
    end

    def set_pettable_types
      @pettable_types = [ "Dog", "Cat" ]
    end

    def pet_params
      params.expect(pet: [ :pettable_type, :name, :date_of_birth, :sex, :pettable_params ])

      pettable_type = params.dig(:pet, :pettable_type)
      pettable_params = PETTABLE_PARAMS[pettable_type] || []

      params.require(:pet).permit(:pettable_type, :name, :date_of_birth, :sex,
                                  pettable_params: pettable_params)
    end
end
