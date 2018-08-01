class Score < ApplicationRecord
  belongs_to :usuario_puntuador, :class_name => 'User'
  belongs_to :usuario_puntuado, :class_name => 'User'
  has_one :viaje

  #ACLARACION ESTADOS
  # 1 = pendiente
  # 2 = realizado

  def calificacion_neutral
  	self.estado = 2
  	self.save
  end

  def calificacion_positiva
  	self.usuario_puntuado.calificacion_positiva(self.tipo)
  	self.estado = 2
	self.save  	
  end

  def calificacion_negativa
  	self.usuario_puntuado.calificacion_negativa(self.tipo)
  	self.estado = 2
  	self.save
  end

end
