# app/models/user.rb
class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
