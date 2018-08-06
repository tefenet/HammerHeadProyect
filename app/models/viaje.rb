class Viaje < ApplicationRecord
  belongs_to :chofer, :class_name => "User"
  has_and_belongs_to_many :pasajeros, :class_name => "User"
  has_one :car
  belongs_to :semana
  has_many :comments
  has_many :requests, :dependent=> :destroy
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
  before_destroy :check_solicitudes_aprobadas

  def cant_be_edited
    return (self.pasajeros.any? or Request.where("viaje_id = ? AND state = ?", self.id , 1).any?)
  end

  def check_solicitudes_aprobadas
    if self.pasajeros.any?
      chofer = User.find(self.chofer_id)
      if (chofer.reputacion_chofer != 0)
        chofer.reputacion_chofer -= 1
      end
      self.pasajeros.each { |pas|  MyMailer.viajeBaja(pas, self).deliver_later(wait: 0.001.second)}
      chofer.save
    end
  end

  def add_Pasajero(aUser)
    self.pasajeros<<aUser
    self.update_column(:asientos_libres, asientos_libres-1)
  end

  def removePasajero(aUser)
    self.pasajeros.delete(aUser)
    self.update_column(:asientos_libres, asientos_libres+1)
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

  def not_started
    return (DateTime.now < (DateTime.parse(fecha.to_s + ' ' + hora.to_s)))
  end

  def validate_viajes_overlaping
    if fecha && hora && duracion
      if (self.startT > self.finishT)
        errors.add(:base, 'El viaje no puede terminar antes de la hora de inicio(ingrese un numero mayor a 0)')
      end
      if (chofer.viajesComoChofer.select{ |un_viaje| (startT..finishT).overlaps?(un_viaje.finishT..un_viaje.startT) && (self.id != un_viaje.id) }.any?)
        errors.add(:base, 'El usuario posee 1 o mas viajes en este momento')
      end
      if self.cant_be_edited
        errors.add(:base, 'Este viaje tiene solicitudes pendientes o aprobadas')
      end
    end
  end

  def pending_califications
    self.requests.select{|r| r.puntajePasajeroPendiente && self.fecha<30.days.ago}
  end

  def generarPuntajes
    self.generarPuntajesChofer
    self.generarPuntajesPasajero
  end

  def generarPuntajesChofer
    #Genera puntaje de los pasajeros hacia el chofer
    self.pasajeros.each do |pasajero|
      Score.create(usuario_puntuador_id: pasajero.id, usuario_puntuado_id: self.chofer_id, estado: 1, viaje_id: self.id, tipo: "Chofer", fecha: self.fecha)
    end
    #Genera puntaje del chofer hacia los pasajeros
    self.pasajeros.each do |pasajero|
      Score.create(usuario_puntuador_id: self.chofer_id, usuario_puntuado_id: pasajero.id, estado: 1, viaje_id: self.id, tipo: "Pasajero", fecha: self.fecha)
    end
  end

  def generarPuntajesPasajero
    #Doble for, genera calificaciones entre pasajeros
    self.pasajeros.each do |pasajeroPuntuador|
      self.pasajeros.each do |pasajeroPuntuado|
        if (pasajeroPuntuador.id != pasajeroPuntuado.id)
          Score.create(usuario_puntuador_id: pasajeroPuntuador.id, usuario_puntuado_id: pasajeroPuntuado.id, estado: 1, viaje_id: self.id, tipo: "Pasajero", fecha: self.fecha)
        end
      end
    end
  end

end
