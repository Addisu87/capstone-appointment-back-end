require 'swagger_helper'

RSpec.describe 'api/v1/motorcycles', type: :request do
  path '/api/v1/motorcycles' do
    get('list motorcycles') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object, properties: { id: { type: :integer }, model: { type: :string }, duration: { type: :integer }, price: { type: :integer }, description: { type: :text }, created_at: { type: :string }, updated_at: { type: :string } },
          required: %w[model price]
        }

        let(:id) { Motorcycle.create(model: 'foo', price: 100).id }

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

    post('create motorcycle') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object, properties: { model: { type: :string }, duration: { type: :integer }, price: { type: :integer }, description: { type: :text } },
          required: %w[model price]
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

  path '/api/v1/motorcycles/{id}' do
    get('show motorcycle') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object, properties: { id: { type: :integer }, model: { type: :string }, duration: { type: :integer },
                                       price: { type: :integer }, description: { type: :text }, created_at: { type: :string }, updated_at: { type: :string } }, required: %w[model price]
        }

        let(:id) { Motorcycle.create(model: 'foo', price: 100).id }

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

    patch('update motorcycle') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer }, model: { type: :string }, duration: { type: :integer }, price: { type: :integer }, description: { type: :text },
            created_at: { type: :string }, updated_at: { type: :string }
          }, required: %w[model price]
        }

        let(:id) { Motorcycle.create(model: 'foo', price: 100).id }

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

    put('update motorcycle') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object,
          properties: { id: { type: :integer }, model: { type: :string },
                        duration: { type: :integer }, price: { type: :integer }, description: { type: :text }, created_at: { type: :string }, updated_at: { type: :string } }, required: %w[model price]
        }

        let(:id) { Motorcycle.create(model: 'foo', price: 100).id }

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

    delete('delete motorcycle') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :motorcycle, in: :body, schema: {
          type: :object,
          properties: { id: { type: :integer }, model: { type: :string }, duration: { type: :integer }, price: { type: :integer }, description: { type: :text }, created_at: { type: :string }, updated_at: { type: :string } }, required: %w[model price]
        }

        let(:id) { create(:motorcycle).id }

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
