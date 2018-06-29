class Viaje < ApplicationRecord
  belongs_to :chofer, :class_name => "User"
  has_and_belongs_to_many :pasajeros, :class_name => "User"
  has_one :car

  attr_accessor :car_id
  
  def add_Pasajero(aUser)
    self.pasajeros<<aUser
  end

  def self.searchByRange (range)
    where(fecha:range.begin..range.end)
  end

end
