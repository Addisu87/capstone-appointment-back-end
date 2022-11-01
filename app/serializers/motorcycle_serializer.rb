class MotorcycleSerializer < ActiveModel::Serializer
  attributes :id, :model, :duration, :price, :description,:avatar
  belongs_to :user
end
