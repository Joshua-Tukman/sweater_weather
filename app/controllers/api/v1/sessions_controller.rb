class Api::V1::SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: session_params[:email])
    if user == nil
      render json: Errors.new.invalid_credentials, status: 404
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: 200
    else
      render json: Errors.new.invalid_password, status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end 
end 