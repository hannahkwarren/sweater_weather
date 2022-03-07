# app/spec/requests/book_spec.rb
require 'rails_helper'
RSpec.describe 'Book Search endpoint' do
  it 'returns a summary forecast and list of books', :vcr do
    get '/api/v1/book-search?location=new+york+city,ny&quantity=5'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed = JSON.parse(response.body, symbolize_names: true)
    data = parsed[:data]

    expect(data).to have_key(:id)
    expect(data[:id]).to eq('null')
    expect(data[:attributes]).to have_key(:forecast)
    expect(data[:attributes][:forecast]).to have_key(:summary)
    expect(data[:attributes][:forecast][:summary]).to eq('broken clouds')
    expect(data[:attributes][:forecast]).to have_key(:temperature)
    expect(data[:attributes][:forecast][:temperature]).to eq('70 F')
    expect(data[:attributes]).to have_key(:books)
    expect(data[:attributes][:books][0]).to have_key(:isbn)
    expect(data[:attributes][:books][0][:isbn]).to eq(["9780385155847", "0385155840"])
    expect(data[:attributes][:books][0]).to have_key(:title)
    expect(data[:attributes][:books][0][:title]).to eq("New York Walkbook")
    expect(data[:attributes][:books][0]).to have_key(:publisher)
    expect(data[:attributes][:books][0][:publisher]).to eq(["Anchor"])
  end
end
