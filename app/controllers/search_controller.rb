class SearchController < ApplicationController
  helper SearchHelper
  helper ViajesHelper
  require 'googlecharts'

  def balance
    begin
      rango=helpers.formatDate(params)
    rescue
      return redirect_to balance_path, notice: 'ingrese fechas validas'
    end
    if helpers.validarRango(rango)
        @viajesDeUsuarioenRangoP = User.current.viajesComoPasajero.searchByRange(rango)
        @gasto=helpers.gastoEnViajes(@viajesDeUsuarioenRangoP)
        @viajesDeUsuarioenRango = current_user.viajesComoChofer.searchByRange(rango)
        @ahorro=helpers.ahorroEnViajes(@viajesDeUsuarioenRango)
        @bar = Gchart.pie_3d(:size =>'400x400',:title => "balance en Pesos",:bg => 'efefef',:legend => ['Ahorro '+@ahorro.to_s, 'Gasto '+@gasto.to_s], :data => [@ahorro, @gasto])
        #respond_to do |format|
        #  format.html # balance.html.erb
        #  format.json { render json: @viajesDeUsuarioenRango }
        #end
    else
      return redirect_to balance_path, notice: 'Rango invalido'
    end
  end
end
