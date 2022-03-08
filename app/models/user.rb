# app/models/user.rb
require 'securerandom'
class User < ApplicationRecord
  encrypts :private_api_key
  blind_index :private_api_key
  before_save :set_private_api_key
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates :private_api_key, uniqueness: true, allow_blank: true

  has_secure_password

  private

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
# 
