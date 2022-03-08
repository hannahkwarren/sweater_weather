# app/spec/requests/user_spec.rb
require 'rails_helper'
RSpec.describe 'User Registration' do
  context 'happy path' do
    it 'can create a new user and provide an api key' do
      json_payload = { user: {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      } }

      post '/api/v1/users', params: json_payload

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to have_key(:email)
      expect(parsed[:data][:attributes]).to have_key(:private_api_key)
      expect(parsed[:data][:attributes][:email]).to eq('whatever@example.com')
      expect(parsed[:data][:attributes][:private_api_key]).not_to be_nil
    end
  end

  context 'sad path: raises any validation errors at attempted creation' do
    it 'raises taken error if a user already exists' do
      User.create(email: 'whatever@mail.com', password: 'Pass1234', password_confirmation: 'Pass1234')

      json_payload = { user: {
        email: 'whatever@mail.com',
        password: 'password',
        password_confirmation: 'password'
      } }

      post '/api/v1/users', params: json_payload
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:email]).to eq([{
        error: 'taken',
        value: 'whatever@mail.com'
      }])
    end
  end
end
