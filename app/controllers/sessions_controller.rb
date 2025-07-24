class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to hub_path, notice: "Welcome back, #{user.username}!"
    else
      flash.now[:alert] = "Invalid email or password."
      puts "DEBUG: Setting flash alert - #{flash.now[:alert]}"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been signed out successfully."
  end
end
