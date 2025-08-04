# frozen_string_literal: true

module ApplicationHelper
  def signed_in?
    session[:user_id].present?
  end
end
