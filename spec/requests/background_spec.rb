# app/spec/requests/background_spec.rb
require 'rails_helper'

RSpec.describe 'Background Request' do
  it 'returns a background image', :vcr do
    get '/api/v1/background?location=Baltimore,MD'
    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed = JSON.parse(response.body, symbolize_names: true)
    data = parsed[:data]
    expect(data).to have_key(:type)
    expect(data[:type]).to eq('image')
    expect(data[:attributes]).to have_key(:image)
    expect(data[:attributes][:image]).to have_key(:id)
    expect(data[:attributes][:image][:id]).to eq('CTSDsj_hbu8')
    expect(data[:attributes][:image]).to have_key(:description)
    expect(data[:attributes][:image][:description]).to eq('Street photography in Baltimore, MD.  Photo was made from scanned 35mm film.')

    # per Unsplash terms and conditions, the full :url hash is provided
    expect(data[:attributes][:image]).to have_key(:urls)
    expect(data[:attributes][:image][:urls]).to have_key(:raw)
    expect(data[:attributes][:image][:urls]).to have_key(:full)
    expect(data[:attributes][:image][:urls]).to have_key(:regular)
    expect(data[:attributes][:image][:urls]).to have_key(:small)
    expect(data[:attributes][:image][:urls]).to have_key(:thumb)
    expect(data[:attributes][:image][:urls]).to have_key(:small_s3)

    expect(data[:attributes][:image]).to have_key(:credit)
    expect(data[:attributes][:image][:credit]).to have_key(:username)
    expect(data[:attributes][:image][:credit][:username]).to eq('rwlinder')
    expect(data[:attributes][:image][:credit]).to have_key(:first_name)
    expect(data[:attributes][:image][:credit][:first_name]).to eq('Robert')
    expect(data[:attributes][:image][:credit]).to have_key(:last_name)
    expect(data[:attributes][:image][:credit][:last_name]).to eq('Linder')
    expect(data[:attributes][:image][:credit]).to have_key(:bio)
  end
end
