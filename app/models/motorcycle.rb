class Motorcycle < ApplicationRecord
  belongs_to :user

  validates :model, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true,
                          length: { in: 1..5_000, too_long: '%<count>s characters is the maximum allowed' }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
