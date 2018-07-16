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
        viajesDeUsuarioenRangoP = User.current.search_Pas_ByRange(rango)
        gasto=helpers.gastoEnViajes(viajesDeUsuarioenRangoP)
        viajesDeUsuarioenRango = current_user.search_Ch_ByRange(rango)
        ahorro=helpers.ahorroEnViajes(viajesDeUsuarioenRango)
        @items=(viajesDeUsuarioenRango|viajesDeUsuarioenRangoP).select{ |v| v.pasajeros.count>0}.sort_by{|fecha|  SearchHelper.fechaDePago(fecha)}.reverse!
        @bar = Gchart.pie_3d(:size =>'400x400',:title => "balance en Pesos",:graph_bg => 'cccccc',:theme => :pastel,:custom => 'chdls=0000CC,25', :legend => ['Ahorro $'+ahorro.to_s, 'Gasto $'+gasto.to_s], :data => [ahorro, gasto])
    else
      return redirect_to balance_path, notice: 'Rango invalido'
    end
  end
end
