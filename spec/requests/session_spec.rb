# app/spec/requests/session_spec.rb
require 'rails_helper'
RSpec.describe 'Sessions endpoint' do
  it 'can create a new user' do
    User.create(email: 'whatever@mail.com', password: 'Pass1234', password_confirmation: 'Pass1234')

    post '/api/v1/sessions?email=whatever@mail.com&password=Pass1234'

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:data)
    expect(parsed[:data]).to have_key(:type)
    expect(parsed[:data][:type]).to eq('users')
    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:attributes]).to have_key(:email)
    expect(parsed[:data][:attributes][:email]).to eq('whatever@mail.com')
    expect(parsed[:data][:attributes]).to have_key(:private_api_key)
    expect(parsed[:data][:attributes][:private_api_key]).not_to be_nil
  end

  it 'sad path: invalid credentials' do
    User.create(email: 'whatever@mail.com', password: 'Pass1234', password_confirmation: 'Pass1234')

    json_payload = { "email": "whatever@mail.com", "password": "pass"}
    post '/api/v1/sessions', params: json_payload

    expect(response).to_have http_status(401)
  end
end
