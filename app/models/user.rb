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
    print ('IMPRIMO AUTOS')
    print ('IMPRIMO AUTOS')
    print ('IMPRIMO AUTOS')
    print ('IMPRIMO AUTOS')
    print (self.cars)
    print (self.cars.any?)
    print (self.cars.any?)
    print (self.cars.any?)
    print ('IMPRIMO TARJETA')
    print ('IMPRIMO TARJETA')
    print ('IMPRIMO TARJETA')
    print ('IMPRIMO TARJETA')
    print (self.credit_card_number)
    print (self.credit_card_number != nil)
    print (self.credit_card_number != nil)
    print (self.credit_card_number != nil)
    if ((self.cars.any?) & (self.credit_card_number != nil) & pending_califications())
      return true
    else
      return false
    end
  end

  def full_name
    return self.first_name+' '+self.last_name
  end


  def pending_califications
    return true #Temporal
  end

  private

  def validate_age
      if birth_date.present? && birth_date.to_date > 18.years.ago.to_date
          errors.add(:birth_date, 'Deberias ser mayor de 18 años.')
      end
  end

  has_and_belongs_to_many :viajesComoPasajero, :class_name => "Viaje", :foreign_key => 'pasajero_id'
  has_many :viajesComoChofer, :class_name => "Viaje", :foreign_key => 'chofer_id'
  has_many :cars

  #aca podes cambiar el tamañop de la imagen e usuario
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
