class MotorcycleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :model, :duration, :price, :description
  belongs_to :user
end
