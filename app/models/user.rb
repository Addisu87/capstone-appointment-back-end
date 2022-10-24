class User < ApplicationRecord
  # Add associations
  has_many :motorcycles, foreign_key: 'user_id', dependent: :destroy
  has_many :reservations, foreign_key: 'user_id', dependent: :destroy

  # addiing validation for attributes
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password
end
