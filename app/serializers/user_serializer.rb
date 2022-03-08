# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :users
  attributes :email
  
  attribute :private_api_key do |object|
    object.private_api_key
  end
end
