class User < ApplicationRecord
  has_many :motorcycles, foreign_key: 'user_id', dependent: :destroy
  has_many :reservations, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
