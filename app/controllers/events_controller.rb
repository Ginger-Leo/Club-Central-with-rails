class EventsController < ApplicationController
  before_action :set_event, only: [ :destroy, :update ]
  before_action :require_admin, only: [ :destroy, :update, :create ]

  def update
    if @event
      if @event.update(event_params)
        redirect_to hub_path, notice: "Event was successfully updated."
      else
        redirect_to hub_path, alert: "Failed to update event: #{@event.errors.full_messages.join(', ')}"
      end
    else
      redirect_to hub_path, alert: "Event not found."
    end
  end

  def destroy
    if @event
      @event.destroy
      redirect_to hub_path, notice: "Event was successfully deleted."
    else
      redirect_to hub_path, alert: "Event not found."
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to hub_path, notice: "Event was successfully created."
    else
      redirect_to hub_path, alert: "Failed to create event: #{@event.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:id])
  end

  def event_params
    params.require(:event).permit(:datetime, :event_type, :location, :notes)
  end

  def require_admin
    @user = User.find_by(id: session[:user_id])
    unless @user&.access_level == "admin"
      redirect_to hub_path, alert: "You must be an admin to perform this action."
    end
  end
end
