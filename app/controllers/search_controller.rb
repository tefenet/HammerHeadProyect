class SearchController < ApplicationController
  helper SearchHelper
  helper ViajesHelper
  def balance
    begin
      rango=helpers.formatDate(params)
    rescue
      return redirect_to balance_path, notice: 'ingrese fechas validas'
    end
    if helpers.validarRango(rango)
        @viajesDeUsuarioenRangoP = current_user.viajesComoPasajero.searchByRange(rango)
        @gasto=helpers.gastoEnViajes(@viajesDeUsuarioenRangoP)
        @viajesDeUsuarioenRango = current_user.viajesComoChofer.searchByRange(rango)
        @ahorro=helpers.ahorroEnViajes(@viajesDeUsuarioenRango)
        #respond_to do |format|
        #  format.html # balance.html.erb
        #  format.json { render json: @viajesDeUsuarioenRango }
        #end
    else
      return redirect_to balance_path, notice: 'Rango invalido'
    end
  end
end
