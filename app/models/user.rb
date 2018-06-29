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
    return (has_credit_card & has_any_car & pending_califications)
  end

  def full_name
    return self.first_name+' '+self.last_name
  end


  def pending_califications
    return true
    #Temporal hasta que pongamos calificaciones
  end

  def self.current
      Thread.current[:user]
  end
  def self.current=(user)
      Thread.current[:user] = user
  end
  def viajesPendientesCon(aCar)
      self.viajesComoChofer.where('car_plate=? and fecha>=?',aCar.plate,Date.today)
  end

  def addViajeComoPasajero(unViaje)
    self.viajesComoPasajero<<unViaje
  end

  def has_credit_card
    return !self.credit_card_number.nil?
  end

  def has_any_car
    return self.cars.any?
  end

  private

  def validate_age
      if birth_date.present? && birth_date.to_date > 18.years.ago.to_date
          errors.add(:birth_date, 'Deberias ser mayor de 18 años.')
      end
  end

  has_many :viajesComoPasajero, :class_name => "Viaje", :foreign_key => 'pasajero_id'
  has_many :viajesComoChofer, :class_name => "Viaje", :foreign_key => 'chofer_id'
  has_many :cars
  has_many :card

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
