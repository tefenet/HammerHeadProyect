class ViajeRecurrentesController < ApplicationController
  before_action :set_viaje_recurrente, only: [:show, :edit, :update, :destroy]

  # GET /viaje_recurrentes
  # GET /viaje_recurrentes.json
  def index
    @viaje_recurrentes = ViajeRecurrente.all
  end

  # GET /viaje_recurrentes/1
  # GET /viaje_recurrentes/1.json
  def show
  end

  # GET /viaje_recurrentes/new
  def new
    @viaje_recurrente = ViajeRecurrente.new
  end

  # GET /viaje_recurrentes/1/edit
  def edit
  end

  # POST /viaje_recurrentes
  # POST /viaje_recurrentes.json
  def create
    @viaje_recurrente = ViajeRecurrente.new(viaje_recurrente_params)

    #ya se que es una catarata de ifs y hubiera convenido un vector de 7 (facu no rompas las bolas)
    if (@viaje_recurrente.lunes == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Monday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.martes == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Tuesday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.miercoles == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Wednesday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.jueves == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Thursday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.viernes == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Friday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.sabado == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Saturday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end

    if (@viaje_recurrente.domingo == true) then
      Viaje.create(origen: @viaje_recurrente.origen, destino: @viaje_recurrente.destino,
        fecha: @viaje_recurrente.date_of_next("Sunday")
        ,hora: @viaje_recurrente.hora,
        car_id: @viaje_recurrente.car_id, precio: @viaje_recurrente.precio,
        duracion: @viaje_recurrente.duracion, descripcion: @viaje_recurrente.descripcion)
    end


    respond_to do |format|
      if @viaje_recurrente.save
        format.html { redirect_to @viaje_recurrente, notice: 'Viaje recurrente was successfully created.' }
        format.json { render :show, status: :created, location: @viaje_recurrente }
      else
        format.html { render :new }
        format.json { render json: @viaje_recurrente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /viaje_recurrentes/1
  # PATCH/PUT /viaje_recurrentes/1.json
  def update
    respond_to do |format|
      if @viaje_recurrente.update(viaje_recurrente_params)
        format.html { redirect_to @viaje_recurrente, notice: 'Viaje recurrente was successfully updated.' }
        format.json { render :show, status: :ok, location: @viaje_recurrente }
      else
        format.html { render :edit }
        format.json { render json: @viaje_recurrente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /viaje_recurrentes/1
  # DELETE /viaje_recurrentes/1.json
  def destroy
    @viaje_recurrente.destroy
    respond_to do |format|
      format.html { redirect_to viaje_recurrentes_url, notice: 'Viaje recurrente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viaje_recurrente
      @viaje_recurrente = ViajeRecurrente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viaje_recurrente_params
      params.require(:viaje_recurrente).permit(:semanas)
    end
end
