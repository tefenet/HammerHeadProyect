module ViajesHelper


def gastoEnViajes(coleccionDeViajes)
  coleccionDeViajes.inject(0) {|sum, i|  sum + i.precio }
end
def ahorroEnViajes(coleccionDeViajes)
  coleccionDeViajes.map { |e| e.precio * e.pasajeros.count}
                   .sum
end

end
