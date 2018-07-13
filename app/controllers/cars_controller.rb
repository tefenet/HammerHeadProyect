class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car =current_user.cars.build
  end

  # GET /cars/1/edit
  def edit
    return redirect_to misautos_path(current_user) ,notice: 'no puedes editar un auto si tiene viajes pendientes' unless (User.current.viajesPendientesCon(@car)).empty?
  end

  # POST /cars
  # POST /cars.json
  def create
    @car =current_user.cars.build(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Agregaste un auto!' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Actualizaste los datos del Auto' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    if (current_user.viajesPendientesCon(@car).any?)
        respond_to do |format|
          format.html { redirect_to misautos_path(current_user), notice: 'no puede borrar el auto porque tiene viajes pendientes' }
          format.json { head :no_content }
        end
    else
      @car.destroy
      respond_to do |format|
        format.html { redirect_to misautos_path(current_user), notice: 'El auto fue eliminado exitosamente.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:plate, :seats, :brand, :model)
    end
end
