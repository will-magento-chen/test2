class OrdersController < ApplicationController

  def add_customer
    @contact = Contact.new
    @contact.country = 'US'
    @event = Event.find(params[:event_id])
  end
end
