require 'rails_helper'

RSpec.describe 'Api::V1::Registrations', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/api/v1/registrations/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/registrations/create'
      expect(response).to have_http_status(:success)
    end
  end
end
