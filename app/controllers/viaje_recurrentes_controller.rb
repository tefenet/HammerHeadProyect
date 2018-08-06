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

    respond_to do |format|
      if @viaje_recurrente.save

        @viaje_recurrente.cant_semanas.times do |i|
        #ya se que es una catarata de ifs y hubiera convenido un vector de 7 (facu no rompas las bolas)

        semana = @viaje_recurrente.semanas.build(:viaje_recurrente=> @viaje_recurrente)

        semana.save

        if (@viaje_recurrente.lunes == true) then
          if !create_viaje(1,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.martes == true) then
          if !create_viaje(2,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.miercoles == true) then
          if !create_viaje(3,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.jueves == true) then
          if !create_viaje(4,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.viernes == true) then
          if !create_viaje(5,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.sabado == true) then
          if !create_viaje(6,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        if (@viaje_recurrente.domingo == true) then
          if !create_viaje(0,i,semana.id)
              redirect_to @viaje_recurrente, notice: @errors  and return
          end
        end

        @viaje_recurrente.semanas<<semana

      end

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
        return
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


  def create_viaje(day,i,semID)
    viaje=current_user.viajesComoChofer.build(viaje_params)
    viaje.fecha=@viaje_recurrente.get_next_day(@viaje_recurrente.fecha, day, i)
    viaje.chofer_id = current_user.id
    auto=Car.find(viaje.car_id)
    viaje.car = auto
    viaje.asientos_libres = auto.seats
    viaje.car_plate= auto.plate
    viaje.semana_id=semID
      if !viaje.save
        @errors=viaje.errors.full_messages
        return false
      else
        auto.viajes<<viaje
        s=Semana.find(semID)
        s.viajes<<viaje
        s.save
      end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viaje_recurrente
      @viaje_recurrente = ViajeRecurrente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viaje_recurrente_params
      params.require(:viaje_recurrente).permit!
    end
    def viaje_params
      params.require(:viaje_recurrente).permit(:origen, :destino, :hora,:fecha, :precio, :duracion, :descripcion, :car_id)
    end
end
