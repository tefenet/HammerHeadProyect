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
        errors.add(:base, 'El viaje no puede terminar antes de la hora de inicio')
      end
      if User.current.viajesComoChofer.select{ |un_viaje| (self.startT.between?(un_viaje.startT, un_viaje.finishT))}
        #|| (self.finishT.between?(un_viaje.startT, un_viaje.finishT)) 
        errors.add(:base, 'El usuario posee 1 o mas viajes en este momento')
      end
    end

  end

  def validate_usuario_no_tiene_solicitudes_en_ese_horario
    if inicio.present? && fin.present?
      usuario.solicitud.where(aceptada: true).where(finalizado: false).or(usuario.solicitud.where(aceptada: false).where(rechazada: false)).each do |solicitud|
      if (solicitud.viaje.inicio < (inicio + 3.hours) && solicitud.viaje.fin > (inicio + 3.hours)) || (solicitud.viaje.inicio < (fin + 3.hours) && solicitud.viaje.fin > (fin + 3.hours)) || (solicitud.viaje.inicio > (inicio + 3.hours) && solicitud.viaje.fin < (fin + 3.hours))
        errors.add(:base, 'el usuario ya posee una solicitud en ese momento')
        end
      end
    end
  end

end
