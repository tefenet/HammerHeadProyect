class ViajesController < ApplicationController
  before_action :set_viaje, only: [:show, :edit, :update, :destroy]

  # GET /viajes
  # GET /viajes.json
  def index
    @viajes = Viaje.all
  end

  def add_Pasajero
    Viaje.find(params[:id]).add_Pasajero(current_user)
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
      @viaje = current_user.viajesComoChofer.build
    else
      unless @user.has_any_car
        redirect_to root_path and return flash[:notice] = 'Debe cargar un auto antes de publicar un viaje.'
      end
      unless @user.has_credit_card
        redirect_to root_path and return flash[:notice] = 'Debe cargar una tarjeta de credito antes de publicar un viaje.'
      end
      if (@user.pending_califications > 0)
        redirect_to root_path and return flash[:notice] = 'Tienes calificaciones pendientes, no puedes publicar nuevos viajes'
      end
    end
  end

  # GET /viajes/1/edit
  def edit
    @viaje=Viaje.find(params[:id])
    if @viaje.cant_be_edited then
      redirect_to root_path and return flash[:notice] = 'No se puede modificar el viaje porque tiene solicitudes aceptadas o pendientes.'
    else
      @viaje = Viaje.find(params[:id])
    end
  end

  # POST /viajes
  # POST /viajes.json
  def create
    @viaje = current_user.viajesComoChofer.build(viaje_params)
    @viaje.chofer_id = current_user.id
    auto=Car.find(@viaje.car_id)
    @viaje.car = auto
    @viaje.asientos_libres = auto.seats
    @viaje.car_plate= auto.plate
    auto.viajes<<@viaje
    if !@viaje.semana_id.nil?
      @viaje.semana=Semana.find(@viaje.semana_id)
    else
      @viaje.semana=Semana.new
    end
    respond_to do |format|
      if @viaje.save
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
    @asientos_libres=@viaje.asientos_libres
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
      format.html { redirect_to misviajes_path(current_user), notice: 'El viaje se a eliminado correctamente.' }
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
      params.require(:viaje).permit(:origen, :destino, :fecha, :hora, :precio, :duracion, :descripcion, :car_id,:semana_id)
    end
end
