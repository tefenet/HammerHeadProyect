class Viaje < ApplicationRecord
  belongs_to :chofer, :class_name => "User"
  has_and_belongs_to_many :pasajeros, :class_name => "User"
  has_one :car

  validates :origen, presence: { message: ": Por favor ingrese el origen del viaje"}, on: [:create, :new, :update]
	validates :destino, presence: { message: ": Por favor ingrese el destino del viaje"}, on: [:create, :new, :update]
  validates :fecha, presence: {message: ": Por favor ingrese una fecha para el viaje"}, on: [:create, :new, :update]
  validates :hora, presence: {message: ": Por favor ingrese una hora para el viaje"}, on: [:create, :new, :update]
  validates :precio, presence: { message: ": Por favor ingrese el precio del viaje"}, on: [:create, :new, :update]
  validates :duracion, presence: { message: ": Por favor ingrese una duracion para el viaje"}, on: [:create, :new, :update]
  validate :validate_inicio
  validate :validate_fecha
  validates :car_id, presence: { message: ":Por favor elija un auto"}, on: [:create, :new, :update]
  #validate :validate_viajes_overlaping


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

  def validate_viajes_overlaping
    if fecha && hora && usuario.viaje
      viajes=usuario.viaje.select{ |un_viaje| un_viaje.fecha == fecha }
      if usuario.viaje.where("inicio < ? and fin > ?"  ,(inicio+ 3.hours),(inicio+3.hours)).or(usuario.viaje.where("inicio < ? and fin > ?"  ,(fin+3.hours),(fin+3.hours))).or(usuario.viaje.where("inicio > ? and fin < ?"  ,(inicio+3.hours),(fin+3.hours))).count >= 1
        errors.add(:base, 'el usuario ya posee viaje en ese momento')
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
