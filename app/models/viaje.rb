class Viaje < ApplicationRecord
  belongs_to :chofer, :class_name => "User"
  has_and_belongs_to_many :pasajeros, :class_name => "User"
  has_one :car
  has_many :comments
  validates :origen, presence: { message: ": Por favor ingrese el origen del viaje"}, on: [:create, :new, :update]
	validates :destino, presence: { message: ": Por favor ingrese el destino del viaje"}, on: [:create, :new, :update]
  validates :fecha, presence: {message: ": Por favor ingrese una fecha para el viaje"}, on: [:create, :new, :update]
  validates :hora, presence: {message: ": Por favor ingrese una hora para el viaje"}, on: [:create, :new, :update]
  validates :precio, presence: { message: ": Por favor ingrese el precio del viaje"}, on: [:create, :new, :update]
  validates :duracion, presence: { message: ": Por favor ingrese una duracion para el viaje"}, on: [:create, :new, :update]
  validate :validate_inicio
  validate :validate_fecha
  validates :car_id, presence: { message: ":Por favor elija un auto"}, on: [:create, :new, :update]
  validate :validate_viajes_overlaping


  def add_Pasajero(aUser)
    self.pasajeros<<aUser
  end

  def self.searchByRange(range)
    where(fecha:range.begin..range.end)
  end

  def validate_inicio
    if fecha && hora && (DateTime.parse(fecha.to_s + ' ' + hora.to_s) < 12.hour.from_now)
      errors.add(:inicio, ':El viaje no puede comenzar en menos de 12 horas')
    end
  end

  def validate_fecha
    if fecha && (fecha > 30.days.from_now)
      errors.add(:inicio, ':La Fecha del viaje no puede ser mayor 30 dias desde hoy')
    end
  end

  def validate_car
    if car_id.nil?
      errors.add(:inicio, ':Debe seleccionar un auto')
    end
  end

  def startT
    return (DateTime.parse(fecha.to_s + ' ' + hora.to_s))
  end

  def finishT
    return DateTime.parse(fecha.to_s + ' ' + hora.to_s).advance(:hours => +duracion)
  end

  def validate_viajes_overlaping
    if fecha && hora && duracion
      if (self.startT > self.finishT)
        errors.add(:base, 'El viaje no puede terminar antes de la hora de inicio(ingrese un numero mayor a 0)')
      end
      if (chofer.viajesComoChofer.select{ |un_viaje| (startT..finishT).overlaps?(un_viaje.finishT..un_viaje.startT)}.any?)
        errors.add(:base, 'El usuario posee 1 o mas viajes en este momento')
      end
    end
  end

  def validate_no_pending_requests
  end

end
