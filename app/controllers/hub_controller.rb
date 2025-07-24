class HubController < ApplicationController
  before_action :require_login

  def index
    @upcoming_events = Event.order(datetime: :asc).limit(5)
    @all_events = Event.order(datetime: :asc)

    @roster_players = User.where.not(id: current_user.id)
              .where.not(username: "Admin")
              .order(:username)
              .limit(5)

    @all_roster_players = User.where.not(id: current_user.id)
                             .order(:username)

    @recent_transactions = Finance.where("payer_id = ? OR payee_id = ?", current_user.id, current_user.id)
                                 .order(created_at: :desc).limit(10)
  end

  private

  def require_login
    unless current_user
      redirect_to login_path, alert: "Please log in first."
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
