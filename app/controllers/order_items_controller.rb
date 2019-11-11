class OrderItemsController < ApplicationController
  before_action :product_existed, only: :create
  before_action :load_order_item, :valid_order, only: [:update, :destroy]

  def create
    @order_item = OrderItem.new order_item_params
    if @order_item.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to carts_path
  end

  def update
    if @order_item.update quantity: params[:order_item][:quantity]
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to carts_path
  end

  def destroy
    if @order_item.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to carts_path
  end

  private

  def order_item_params
    params.require(:order_item).permit :product_id, :order_id, :quantity, :price
  end

  def load_order_item
    @order_item = OrderItem.find_by id: params[:id]
    return if @order_item
    flash[:danger] = t ".not_found"
    redirect_to carts_path
  end

  def valid_order
    return if current_order == @order_item.order
    flash[:danger] = t ".fail"
    redirect_to carts_path
  end

  def product_existed
    items = current_order.order_items
    item_exist = items.find_by product_id: params[:order_item][:product_id]
    return unless item_exist
    new_quantity = item_exist.quantity + params[:order_item][:quantity].to_i
    item_exist.update quantity: new_quantity
    flash[:success] = t ".success"
    redirect_to carts_path
  end
end
