# app/serializers/background_serializer.rb
class BackgroundSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :image
  attributes :image
end
