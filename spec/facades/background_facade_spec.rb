# app/spec/facades/background_facade_spec.rb
require 'rails_helper'

RSpec.describe BackgroundFacade do
  it '::background' do
    bg = BackgroundFacade.background('Chicago,IL')
    expect(bg).to be_a(Background)
  end

  context 'helper method' do
    it '::get_image_data' do
      data = BackgroundFacade.get_image_data('Chicago,IL')
      expect(data).to be_a(Hash)
    end
  end
end
