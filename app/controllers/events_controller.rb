# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[destroy]
  before_action :require_admin, only: %i[destroy create]

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to hub_path, notice: 'Event was successfully created.'
    else
      redirect_to hub_path, alert: "Failed to create event: #{@event.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    if @event
      @event.destroy
      redirect_to hub_path, notice: 'Event was successfully deleted.'
    else
      redirect_to hub_path, alert: 'Event not found.'
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:id])
  end

  def event_params
    params.expect(event: %i[datetime event_type location notes])
  end

  def require_admin
    @user = User.find_by(id: session[:user_id])
    return if @user&.access_level == 'admin'

    redirect_to hub_path, alert: 'You must be an admin to perform this action.'
  end
end
