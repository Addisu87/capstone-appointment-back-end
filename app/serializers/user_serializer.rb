class UserSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :name, :token
  has_many :motorcycles

  def token
    @instance_options[:token]
  end
end
