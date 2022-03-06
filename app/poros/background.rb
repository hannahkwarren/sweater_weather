# app/poros/background.rb
class Background
  attr_reader :id, :image

  def initialize(attributes)
    @id = nil
    @image = attributes[:image]
  end
end
