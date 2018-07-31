class Score < ApplicationRecord
  belongs_to :usuario_puntuador, :class_name => 'User'
  belongs_to :usuario_puntuado, :class_name => 'User'
  has_one :viaje

  #ACLARACION ESTADOS
  # 1 = pendiente
  # 2 = realizado

  def generarPuntajes
  	#self generarPuntajesChofer
  end

  def generarPuntajesChofer(pasajero, viaje)
  	#self.usuario_puntuador = pasajero.id
  	#self.usuario_puntuado = viaje.chofer_id
    #self.estado = 1
    #self.viaje_id = viaje.id
  end
end
