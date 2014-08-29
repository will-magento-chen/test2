class EventsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] == "active"
      @events = Event.active.page(params[:page]).per(10)
    elsif params[:status] == "past"
      @events = Event.past.page(params[:page]).per(10)
    else
      @events = Event.page(params[:page]).per(10)
    end
  end

  def new
    @event = Event.new
    @event.country = 'US'
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

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event has been deleted successfully."
  end

  private

  def event_params
    params.require(:event).permit!
  end

  def find_resource
    @event = Event.find(params[:id])
  end
end
