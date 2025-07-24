# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[promote demote]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.access_level = 'player'
    if params[:user][:admin_adding_player]

      if @user.save
        redirect_to hub_path, notice: 'Player added successfully!'
      else
        redirect_to hub_path, alert: 'Failed to add player.'
      end
    elsif @user.save

      redirect_to login_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to hub_path, notice: 'User updated successfully!'
    else
      redirect_to hub_path, alert: 'Failed to update user.'
    end
  end

  def destroy
    @user.destroy
    redirect_to hub_path, notice: 'Player deleted.'
  end

  def promote
    @user = User.find(params[:id])

    @user.update(access_level: 'admin')
    flash[:notice] = "#{@user.username} has been promoted to admin!"

    redirect_to hub_path
  end

  def demote
    @user = User.find(params[:id])
    User.find_by(id: session[:user_id])

    if @user.update(access_level: 'player')
      flash[:notice] = "#{@user.username} has been demoted to player!"
    else
      flash[:alert] = 'Error demoting user.'
    end

    redirect_to hub_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    current_user = User.find_by(id: session[:user_id])
    if current_user&.access_level == 'admin' || params[:user][:admin_adding_player]
      params.require(:user).permit(:username, :email, :password, :position, :chain, :car, :location)
    else
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
