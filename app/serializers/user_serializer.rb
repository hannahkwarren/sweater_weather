# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :user
  attributes :email, :private_api_key
end
# {
#   "data": {
#     "type": "users",
#     "id": "1",
#     "attributes": {
#       "email": "whatever@example.com",
#       "api_key": "jgn983hy48thw9begh98h4539h4"
#     }
#   }
# }
