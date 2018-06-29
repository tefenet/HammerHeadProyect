class Viaje < ApplicationRecord
  belongs_to :chofer, :class_name => "User"
  has_and_belongs_to_many :pasajeros, :class_name => "User"
  has_one :car

<<<<<<< HEAD
  validates :origen, presence: { message: ": Por favor ingrese el origen del viaje"}, on: [:create, :new, :update]
	validates :destino, presence: { message: ": Por favor ingrese el destino del viaje"}, on: [:create, :new, :update]
  validates :fecha, presence: {message: ": Por favor ingrese una fecha para el viaje"}, on: [:create, :new, :update]
  validates :hora, presence: {message: ": Por favor ingrese una hora para el viaje"}, on: [:create, :new, :update]
  validates :precio, presence: { message: ": Por favor ingrese el precio del viaje"}, on: [:create, :new, :update]
  validates :duracion, presence: { message: ": Por favor ingrese una duracion para el viaje"}, on: [:create, :new, :update]

=======
  attr_accessor :car_id
  
>>>>>>> 85a2e26543f3acba30925b3866afb6fb4926993a
  def add_Pasajero(aUser)
    self.pasajeros<<aUser
  end

  def self.searchByRange (range)
    where(fecha:range.begin..range.end)
  end

end
