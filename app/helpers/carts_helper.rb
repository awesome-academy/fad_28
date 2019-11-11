module CartsHelper
  def active order
    session[:order] = order.id
  end

  def create_new_order
    order = Order.new
    order.save_order_token
    active order
    cookies.permanent.signed[:order] = order.id
    cookies.permanent[:order_token] = order.remember_token
    @current_order = order
  end

  def current_order
    if session[:order]
      @current_order ||= Order.find_by id: session[:order]
    elsif cookies.signed[:order]
      order = Order.find_by id: cookies.signed[:order]
      if order&.authenticate? cookies[:order_token]
        active order
        @current_order = order
      end
    else
      create_new_order
    end
  end

  def total_price_for order_item
    order_item.quantity * order_item.price
  end
end
