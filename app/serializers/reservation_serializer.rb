class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :city, :date
  belongs_to :user, :motorcycle
end
