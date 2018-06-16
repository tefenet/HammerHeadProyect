class Car < ApplicationRecord
  belongs_to :user
  validates :plate, uniqueness: true, :length => {:minimum => 6, :maximum => 6, message:"la patente debe tener 6 caracteres"}, format:{with: /\A([a-zA-Z]{3})-?([0-9]{3})$\z/i, message:"la patente comienza con 3 letras y termina con 3 numeros"}
  validates :seats, numericality: {greater_than: 0, less_than:8, message:"vehiculos hasta 8 asientos"}
  before_validation :clean_data

def clean_data
  self.plate = self.plate.gsub(/[ \-]/, '') unless self.plate.nil?
end
end
