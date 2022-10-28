class MotorcycleSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user
  attributes :id, :model, :duration, :price, :description
end
