class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :birth_date, presence: { message: ": Por favor ingrese su fecha de nacimiento" }
  validate :validate_age

  validates :first_name, presence: { message: ": Por favor ingrese su nombre" }
  validates :last_name, presence: { message: ": Por favor ingrese su apellido" }

  validates :password, presence: { message: ": Por favor ingrese una contraseña" }

  private

  def validate_age
      if birth_date.present? && birth_date.to_date > 18.years.ago.to_date
          errors.add(:birth_date, 'Deberias ser mayor de 18 años.')
      end
  end

end
