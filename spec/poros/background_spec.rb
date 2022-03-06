# app/spec/poros/background_spec.rb
require 'rails_helper'
RSpec.describe Background do
  before(:each) do
    @attributes = {:image=>
      {:id=>"CTSDsj_hbu8",
       :description=>"Street photography in Baltimore, MD.  Photo was made from scanned 35mm film.",
       :location=>"Baltimore,MD",
       :urls=>
        {:raw=>
          "https://images.unsplash.com/photo-1642263814576-a6e68dfc4ded?ixid=MnwzMDc4Mzh8MHwxfHNlYXJjaHwxfHxCYWx0aW1vcmUlMkNNRHxlbnwwfDB8fHwxNjQ2NjA0NTk4&ixlib=rb-1.2.1",
         :full=>
          "https://images.unsplash.com/photo-1642263814576-a6e68dfc4ded?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMDc4Mzh8MHwxfHNlYXJjaHwxfHxCYWx0aW1vcmUlMkNNRHxlbnwwfDB8fHwxNjQ2NjA0NTk4&ixlib=rb-1.2.1&q=85",
         :regular=>
          "https://images.unsplash.com/photo-1642263814576-a6e68dfc4ded?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc4Mzh8MHwxfHNlYXJjaHwxfHxCYWx0aW1vcmUlMkNNRHxlbnwwfDB8fHwxNjQ2NjA0NTk4&ixlib=rb-1.2.1&q=80&w=1080",
         :small=>
          "https://images.unsplash.com/photo-1642263814576-a6e68dfc4ded?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc4Mzh8MHwxfHNlYXJjaHwxfHxCYWx0aW1vcmUlMkNNRHxlbnwwfDB8fHwxNjQ2NjA0NTk4&ixlib=rb-1.2.1&q=80&w=400",
         :thumb=>
          "https://images.unsplash.com/photo-1642263814576-a6e68dfc4ded?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc4Mzh8MHwxfHNlYXJjaHwxfHxCYWx0aW1vcmUlMkNNRHxlbnwwfDB8fHwxNjQ2NjA0NTk4&ixlib=rb-1.2.1&q=80&w=200",
         :small_s3=>"https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1642263814576-a6e68dfc4ded"},
       :credit=>
        {:username=>"rwlinder",
         :first_name=>"Robert",
         :last_name=>"Linder",
         :bio=>
          "I have been taking pictures for my own entertainment for more than 60 years.  Hope you enjoy looking at a few of them."}}}
  end

  it 'exists' do
    bg = Background.new(@attributes)
    expect(bg).to be_a(Background)
    expect(bg.image).to be_a(Hash)
    expect(bg.image[:id]).to eq('CTSDsj_hbu8')
    expect(bg.image[:description]).to eq('Street photography in Baltimore, MD.  Photo was made from scanned 35mm film.')
    expect(bg.image[:urls]).to be_a(Hash)
    expect(bg.image[:credit]).to be_a(Hash)
  end
end
