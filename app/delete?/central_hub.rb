
# class DashboardController < ApplicationController
#   before_action :require_login

#   def index
#     @current_user = current_user
#   end

#   private
#   def require_login
#     redirect_to login_path, alert: "You must be logged in to access this page." unless current_user
#   end
# end
