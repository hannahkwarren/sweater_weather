# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    
    if new_user.save
      render json: UserSerializer.new(new_user)
    else
      render json: new_user.errors.details, status: 400
    end
  end

  def login
    user = User.find_by(email: params[:email])
    # binding.pry
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user)
    else
      render json: { error: { message: 'Invalid credentials.' } }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
