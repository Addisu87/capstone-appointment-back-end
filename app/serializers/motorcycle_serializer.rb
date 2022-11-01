class MotorcycleSerializer < ActiveModel::Serializer
  attributes :id, :model, :duration, :price, :description
  belongs_to :user
end
