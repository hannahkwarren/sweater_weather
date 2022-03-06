# app/poros/background.rb
class Background
  attr_reader :image

  def initialize(attributes)
    @image = attributes[:image]
  end
end
