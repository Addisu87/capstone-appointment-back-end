class MotorcycleUserSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :name
end
