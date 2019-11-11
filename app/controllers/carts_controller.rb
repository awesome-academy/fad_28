class CartsController < ApplicationController
  def index
    @all_items = current_order.order_items.includes(:product).newest
    @total = @all_items.reduce(0){|a, e| a + e.quantity * e.price}
  end
end
