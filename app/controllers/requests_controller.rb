class RequestsController < ApplicationController
    before_action :set_request, only: [:change,:show,:update, :destroy]
    before_action :seats, only: [:create]
    before_action :superpocision, only: [:create]

    def new
      @request=Request.new(request_params)
    end

    def create
      @request =current_user.requests.build(request_params)
      respond_to do |format|
        if @request.save
          MyMailer.nueva_Solicitud(@request).deliver_later(wait: 0.001.second)
          format.html { redirect_to viaje_path(@request.viaje.id), alert: 'enviamos tu solicitud puedes comunicarte con el chofer en la seccion preguntas aqui abajo' }
          format.json { render :show, status: :created, location: @request }
        else
          format.html { redirect_to viaje_path(@request.viaje.id), notice: @request.errors.full_messages.last}
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    end

    def change
      @request.change(request_params[:cambio].to_i)
      redirect_to solicitudes_path(current_user), notice: (@request.errors.full_messages.inject('') {|str, error_explanation|  str << error_explanation } )
    end

    def show
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:request][:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:viaje,:state,:passengerScore, :driverScore, :user ,:cambio,:comment).merge(viaje: Viaje.find(params[:request][:viaje]))
    end

    def seats
      v=Viaje.find(params[:request][:viaje])
      unless v.asientos_libres > 0
          redirect_to viaje_path(v.id), notice: 'no hay mas lugares'
      end
    end
    def superpocision
      idViaje=params[:request][:viaje]
      if !Viaje.find(idViaje).es_recurrente
        unless User.current.can_Travel(idViaje)
          redirect_to viaje_path(idViaje), notice: 'tienes otro viaje que se superpone con este'
        end
      else
        unless User.current.can_TravelR(idViaje)
          redirect_to viaje_path(idViaje), notice: 'tienes otro viaje que se superpone con este'
        end
      end
    end

  end
