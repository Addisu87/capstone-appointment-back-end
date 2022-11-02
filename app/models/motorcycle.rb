class Motorcycle < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_one_attached :image
  belongs_to :user

  # addiing validation for attributes
  validates :model, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true,
                          length: { in: 1..5_000, too_long: '%<count>s characters is the maximum allowed' }
  validates :price, presence: true, numericality: { greater_than: 0 }

  def avatar_url
    Rails.application.routes.url_helpers.url_for(image)
  end
end
