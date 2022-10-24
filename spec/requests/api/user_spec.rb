require 'swagger_helper'

RSpec.describe 'api/user', type: :request do
  describe 'Users API' do
    path '/api/v1/users' do
      post 'Create a User' do
        tags 'Users'
        consumes 'application/json', 'application/xml'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: %w[name]
        }

        response '201', 'User created' do
          let(:user) do
            {
              name: 'test'
            }
          end
          run_test!
        end

        response '400', 'Invalid request' do
          let(:user) do
            {
              name: ''
            }
          end
          run_test!
        end
      end
    end
  end
end
