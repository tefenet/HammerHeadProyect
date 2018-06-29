class ViajesController < ApplicationController
  before_action :set_viaje, only: [:show, :edit, :update, :destroy]

  # GET /viajes
  # GET /viajes.json
  def index
    @viajes = Viaje.all
  end

  def add_Pasajero
    @viaje =Viaje.find(params[:id])
    @viaje.add_Pasajero(current_user)
    current_user.addViajeComoPasajero(@viaje)
  end

  # GET /viajes/1
  # GET /viajes/1.json
  def show
    @viaje = Viaje.find(params[:id])
  end

  # GET /viajes/new
  def new
    @user = current_user
    if (@user.can_publish())
      @viaje = current_user.viajesComoChofer.build(viaje_params)
    else
      unless @user.has_any_car
        redirect_to root_path and return flash[:notice] = 'Debe cargar un auto antes de publicar un viaje.'
      end
      unless @user.has_credit_card
        redirect_to root_path and return flash[:notice] = 'Debe cargar una tarjeta de credito antes de publicar un viaje.'
      end
    end
  end

  # GET /viajes/1/edit
  def edit
  end

  # POST /viajes
  # POST /viajes.json
  def create
    @viaje = current_user.viajesComoChofer.build(viaje_params)
    @viaje.chofer_id = current_user.id
    @viaje.car_id = Car.find(params[:viajẹ][:id_auto])
    @viaje.asientos_libres = (Car.find(params[:viajẹ][:id_auto])).seats

    respond_to do |format|
      if @viaje.save!
        format.html { redirect_to @viaje, notice: 'Viaje creado con exito.' }
        format.json { render :show, status: :created, location: @viaje }
      else
        format.html { render :new }
        format.json { render json: @viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /viajes/1
  # PATCH/PUT /viajes/1.json
  def update
    respond_to do |format|
      if @viaje.update(viaje_params)
        format.html { redirect_to @viaje, notice: 'El viaje a sido modificado.' }
        format.json { render :show, status: :ok, location: @viaje }
      else
        format.html { render :edit }
        format.json { render json: @viaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /viajes/1
  # DELETE /viajes/1.json
  def destroy
    @viaje.destroy
    respond_to do |format|
      format.html { redirect_to viajes_url, notice: 'El viaje se a eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_viaje
    @viaje = Viaje.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viaje_params
      params.require(:viaje).permit(:origen, :destino, :fecha, :hora, :precio, :duracion, :descripcion, :car_id)
    end
end
