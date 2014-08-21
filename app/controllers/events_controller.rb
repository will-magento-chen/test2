class EventsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.page(params[:page]).per(10)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: "Event has been created successfully"
    else
      redirect_to :back, alert: "Unable to create event"
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to events_path, notice: "Event has been updated successfully"
    else
      redirect_to :back, alert: "Unable to update event"
    end
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def find_resource
    @event = Event.find(params[:id])
  end
end
