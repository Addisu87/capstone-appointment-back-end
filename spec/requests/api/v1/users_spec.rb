require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    post('create user') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            password: { type: :string }
          },
          required: %w[name password]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/login' do
    get('login user') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            password: { type: :string },
            role: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[name password]
        }

        let(:id) { User.create(name: 'foo', password: 'password').id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
