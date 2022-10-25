class MotorcycleSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :model
  belongs_to :user, serializer: MotorcycleSerializer
end
