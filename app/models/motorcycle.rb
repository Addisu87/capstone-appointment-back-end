class Motorcycle < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  # addiing validation for attributes
  validates :model, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true,
                          length: { in: 1..5_000, too_long: '%<count>s characters is the maximum allowed' }
  validates :price, presence: true, numericality: { greater_than: 0 }

  include Rails.application.routes.url_helpers
  def avatar
    return unless object.avatar.attached?

    {
      url: rails_blob_path(object.avatar, only_path: true)
    }
  end
end
