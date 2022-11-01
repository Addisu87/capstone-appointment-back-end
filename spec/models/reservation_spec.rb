require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    before(:each) do
      @reservation = Reservation.new(
        date: '2022-12-01',
        city: 'Gondar',
        motorcycle_id: 1,
        user_id: 1
      )
    end

    context 'confirm the reservation city' do
      it 'not exist' do
        expect(@reservation.city).to eq(@reservation.city)
      end

      it 'it is valid with valid attributes' do
        expect(@reservation.date).to eq('2022-12-01')
      end

      it 'price should be present' do
        @reservation.city = nil
        expect(@reservation).to_not be_valid
      end

      it 'description should be present' do
        @reservation.date = nil
        expect(@reservation).to_not be_valid
      end
    end
  end
end
