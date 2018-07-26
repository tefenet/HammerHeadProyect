class Score < ApplicationRecord
  belongs_to :usuario_puntuador, :class_name => 'User'
  belongs_to :usuario_puntuado, :class_name => 'User'
end
