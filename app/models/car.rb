class Car < ApplicationRecord
  belongs_to :user
  validates :plate, uniqueness: true
end
