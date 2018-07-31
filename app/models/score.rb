class Score < ApplicationRecord
  belongs_to :usuario_puntuador, :class_name => 'User'
  belongs_to :usuario_puntuado, :class_name => 'User'
  has_one :viaje

  #ACLARACION ESTADOS
  # 1 = pendiente
  # 2 = realizado

  def calificacion_neutral(usuario, tipo)
  	
  end

  def calificacion_positiva(usuario, tipo)
  	
  end

  def calificacion_negativa(usuario, tipo)
  	
  end

end
