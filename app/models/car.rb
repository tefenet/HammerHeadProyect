class Car < ApplicationRecord
  belongs_to :user
  validates :plate, uniqueness: true
  validates :seats, numericality: {greater_than: 0, less_than:8}
end
