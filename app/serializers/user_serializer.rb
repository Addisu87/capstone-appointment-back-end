class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
  has_many :motorcycles
end
