require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/reservations' do
    get('list reservations') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            city: { type: :string },
            date: { type: :string },
            user_id: { type: :integer },
            motorcycle_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[city date]
        }

        let(:id) { Reservation.create(city: 'Gondar', date: '09-09-2022').id }

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

    post('create reservation') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            city: { type: :string },
            date: { type: :string }
          },
          required: %w[city date]
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

  path '/api/v1/reservations/{id}' do
    get('show reservation') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            city: { type: :string },
            date: { type: :string },
            user_id: { type: :integer },
            motorcycle_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[city date]
        }

        let(:id) { Reservation.create(city: 'Gondar', date: '09-09-2022').id }

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

    patch('update reservation') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            city: { type: :string },
            date: { type: :string },
            user_id: { type: :integer },
            motorcycle_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[city date]
        }

        let(:id) { Reservation.create(city: 'Gondar', date: '09-09-2022').id }

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

    put('update reservation') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            city: { type: :string },
            date: { type: :string },
            user_id: { type: :integer },
            motorcycle_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[city date]
        }

        let(:id) { Reservation.create(city: 'Gondar', date: '09-09-2022').id }

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

    delete('delete reservation') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            city: { type: :string },
            date: { type: :string },
            user_id: { type: :integer },
            motorcycle_id: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: %w[city date]
        }

        let(:id) { create(:reservation).id }

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
