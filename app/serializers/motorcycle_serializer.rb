class MotorcycleSerializer < ActiveModel::Serializer
  attributes :id, :model
  belongs_to :user, serializer: MotorcycleSerializer
end
