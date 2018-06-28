class Car < ApplicationRecord
  belongs_to :user
  has_many :viajes
  validates :plate, uniqueness: true, :length => {:minimum => 6, :maximum => 7, message:"Patente invalida"}, format:{with:/\A([A-Z]{2}+[0-9]{3}+[A-Z]{2})\z|\A([A-Z]{3}+[0-9]{3})$\z/i, message:"Formato invalido"}
  validates :seats, numericality: {greater_than: 0, message:"El minimo de acientos es 1"}
  before_validation :clean_data

def clean_data
  self.plate = self.plate.gsub(/[ \-]/, '').upcase unless self.plate.nil?
end
end
