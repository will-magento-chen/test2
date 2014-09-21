class ShoppingController < ApplicationController
  
  def start
    if request.post?
      @event = Event.find(params[:event_id]) if params[:event_id]
      shopping_context = {}
      shopping_context[:address] = params[:address] unless params[:address].blank?
      if @event && params[:order_type] != 'non-event'
        shopping_context[:event_code] = @event.affiliate_code if @event
      end
      shopping_context[:order_type] = params[:order_type]
      cookies[:bf_shop_ctx] = shopping_context.to_json
    end
  end
end
