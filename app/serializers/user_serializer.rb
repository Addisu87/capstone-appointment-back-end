class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :token
  has_many :motorcycles

  def token
    @instance_options[:token]
  end
end
