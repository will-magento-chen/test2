class ShoppingController < ApplicationController

  def start
    if request.post?
      # if user clicks 'Start shopping' button, go to personal order cart page
      if params[:order_type] == "personal"
        cookies.delete(:bf_shop_ctx)
        cookies[:bf_shop_ctx] = {
          domain: 'barefootbooks.com', # TODO don't hardcode this
          expires: 1.day.ago
        }

        redirect_to magento_url('checkout/cart')
      else
        @event = Event.find(params[:event_id]) if params[:event_id]
        shopping_context = {}
        shopping_context[:address] = params[:address] unless params[:address].blank?
        if @event && params[:order_type] != 'non-event'
          shopping_context[:id] = @event.id
          shopping_context[:event_code] = @event.affiliate_code
          shopping_context[:event_name] = @event.name
        end
        shopping_context[:order_type] = params[:order_type]
        cookies[:bf_shop_ctx] = {
          domain: 'barefootbooks.com', # TODO don't hardcode this
          value: shopping_context.to_json,
          expires: 1.day.from_now
        }

        redirect_to add_customer_orders_path(event_id: @event.id)
      end
    end
  end
end
