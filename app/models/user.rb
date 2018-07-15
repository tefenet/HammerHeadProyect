class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :birth_date, presence: { message: ": Por favor ingrese su fecha de nacimiento" }
  validate :validate_age

  validates :first_name, presence: { message: ": Por favor ingrese su nombre" }
  validates :last_name, presence: { message: ": Por favor ingrese su apellido" }

  validates :password, presence: { message: ": Por favor ingrese una contraseña" }, on: [:create, :new]

  def can_publish
    return (has_credit_card && has_any_car && (pending_califications.!))
  end

  def can_Travel(idViaje)
    r=Viaje.find(idViaje)
    self.viajes.find{|un_viaje| (r.startT..r.finishT).overlaps?(un_viaje.finishT..un_viaje.startT)}.nil?
  end

  def viajes
    viajesComoChofer + viajesComoPasajero
  end

  def full_name
    return self.first_name+' '+self.last_name
  end

  def reputacionPA
    self.requests.inject(0) {|sum, i|  sum + i.passengerScore }
  end

  def reputacionCH
    self.viajesComoChofer.requests.inject(0) {|sum, i|  sum + i.driverScore }
  end

  def pending_califications
    ((self.requests.select{|r| r.puntajeChoferPendiente && r.viaje.fecha<30.days.ago}) +
    (self.viajesComoChofer.collect{|v| v.pending_califications})).flatten.any?
    #driverScore 1 positivo; -1 negativo; 0:depende, si state=1 significa 'pendiente', si state=3 significa neutro
  end

  def self.current
      Thread.current[:user]
  end
  def self.current=(user)
      Thread.current[:user] = user
  end
  def viajesPendientesCon(aCar)
      self.viajesComoChofer.where('car_id=? and fecha>=?',aCar.id,Date.today)
  end

  def addViajeComoPasajero(unViaje)
    self.viajesComoPasajero<<unViaje
  end

  def has_credit_card
    return self.cards.any?
  end

  def can_Pay(unViaje)
    if has_credit_card
      self.cards.first.can_pay_when(unViaje.fecha)
    else
      true
    end
  end

  def has_any_car
    return self.cars.any?
  end

  def misSolicitudes
    self.viajesComoChofer.collect{|v|v.requests}.flatten
  end

  def search_Pas_ByRange(rango)
    if rango.end <Date.today
      viajesComoPasajero.where(fecha:rango.begin..rango.end)
    else
      viajesComoPasajero.where(fecha:rango.begin..Date.yesterday) + viajesComoPasajero.select{|v| v.fecha==Date.today && v.startT < DateTime.now }
    end
  end

  def search_Ch_ByRange(rango)

    if rango.end <Date.today
      viajesComoChofer.where(fecha:rango.begin..rango.end)
    else
      viajesComoChofer.where(fecha:rango.begin..Date.yesterday) + viajesComoChofer.select{|v| v.fecha==Date.today && v.finishT < DateTime.now }
    end

  end

  private

  def validate_age
    if birth_date.present? && birth_date.to_date > 18.years.ago.to_date
      errors.add(:birth_date, 'Deberias ser mayor de 18 años.')
    end
  end

  has_and_belongs_to_many :viajesComoPasajero, :class_name => "Viaje"
  has_many :viajesComoChofer, :class_name => "Viaje", :foreign_key => 'chofer_id'
  has_many :cars
  has_many :cards
  has_many :comments
  has_many :requests

  #aca podes cambiar el tamañop de la imagen de usuario
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

#  def can_publish
#    print ('IMPRIMO AUTOS')
#    print (self.cars)
#    print (self.cars.any?)
#    print ('IMPRIMO TARJETA')
#    print (self.credit_card_number)
#    print (self.credit_card_number != nil)
#    return ((self.cars.any?) & has_credit_card & pending_califications())
#  end

end
