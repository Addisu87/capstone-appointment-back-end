class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :motorcycle

  # addiing validation for attributes
  validates :city, presence: true
  validates :date, presence: true
end
