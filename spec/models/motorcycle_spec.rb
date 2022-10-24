require 'rails_helper'

RSpec.describe Motorcycle, type: :model do
  describe 'validations' do
    before(:each) do
      @user = User.create(name: 'Addisu')
      @motorcycle = Motorcycle.create(
        model: 'Neiman Marcus Limited Edition Fighter',
        avatar: 'https://cdn.wealthygorilla.com/wp-content/uploads/2019/06/Most-Expensive-Motorbikes-Neiman-Marcus-Limited-Edition-Fighter.webp',
        duration: 48,
        price: 11_000_000,
        description: 'The Neiman Marcus Limited Edition Fighter is an exclusive streetfighter motorcycle.'
      )
    end

    context 'confirm the motorcycle model' do
      it 'not exist' do
        expect(@motorcycle.model).to eq(@motorcycle.model)
      end
    end

    it 'it is valid with valid attributes' do
      expect(@motorcycle.duration).to eq(48)
    end

    it 'price should be present' do
      @motorcycle.price = nil
      expect(@motorcycle).to_not be_valid
    end

    it 'description should be present' do
      @motorcycle.description = nil
      expect(@motorcycle).to_not be_valid
    end
  end
end
