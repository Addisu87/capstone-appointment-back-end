class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :token
  has_many :motorcycles
end
