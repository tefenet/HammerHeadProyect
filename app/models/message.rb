class Message
  include ActiveModel::Model
  attr_accessor :nombre, :email, :mensaje
  validates :nombre, :email, :mensaje, presence: true
end
