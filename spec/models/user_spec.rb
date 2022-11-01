require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.create(name: 'Addisu', role: 'admin', password: 'password')
  end

  context 'When testing User clsss' do
    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'Should have name' do
      expect(user.name).to eq('Addisu')
    end

    it 'Should have role' do
      expect(user.role).to eq('admin')
    end

    it 'should have password' do
      expect(user.password).to eq('password')
    end
  end
end
