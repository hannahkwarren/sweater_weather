# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.find_or_create_by(user)
    if new_user.present?
      binding.pry
      render json: UserSerializer.new(new_user)
    else
      render status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
