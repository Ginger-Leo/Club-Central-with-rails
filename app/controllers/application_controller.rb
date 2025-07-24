# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  private

  def require_admin
    current_user = User.find_by(id: session[:user_id])
    return if current_user&.access_level == 'admin'

    redirect_to hub_path, alert: 'Admin access required'
  end
end
