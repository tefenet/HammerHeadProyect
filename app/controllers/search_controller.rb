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
        @viajesDeUsuarioenRangoP = User.current.search_Pas_ByRange(rango)
        @gasto=helpers.gastoEnViajes(@viajesDeUsuarioenRangoP)
        @viajesDeUsuarioenRango = current_user.search_Ch_ByRange(rango)
        @ahorro=helpers.ahorroEnViajes(@viajesDeUsuarioenRango)
        @bar = Gchart.pie_c(:size =>'400x400',:title => "balance en Pesos",:chart_background => 'FF9994',:custom => "chdls=0000CC,25", :legend_size => '30',:legend => ['Ahorro $'+@ahorro.to_s, 'Gasto $'+@gasto.to_s], :data => [@ahorro, @gasto])
    else
      return redirect_to balance_path, notice: 'Rango invalido'
    end
  end
end
