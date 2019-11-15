class CartsController < ApplicationController
  before_action :try_out_params, :load_item_existed, only: :create
  before_action :load_key_item, only: [:update_quantity, :destroy_item]

  def index
    @products = Product.by_ids @cart.keys
    @total = @products.reduce(0) do |sum, product|
      sum + @cart[product.id.to_s] * price_for(product)
    end
  end

  def create
    if @cart[@product_id] + params[:quantity].to_i > Settings.max_quantity
      flash[:danger] = t ".too_much"
    else
      @cart[@product_id] += params[:quantity].to_i
      flash[:success] = t ".updated"
    end
    redirect_to carts_path
  end

  def update_quantity
    @cart[@product_id] = params[:quantity].to_i
    flash[:success] = t ".updated"
    redirect_to carts_path
  end

  def destroy_item
    @cart.delete @product_id
    flash[:success] = t ".success"
    redirect_to carts_path
  end

  private

  def load_key_item
    @product_id = params[:product_id]
    return if @cart.include? @product_id
    flash[:danger] = t ".not_found"
    redirect_to carts_path
  end

  def load_item_existed
    @product_id = params[:product_id]
    return if @cart.include? @product_id
    @cart[@product_id] = params[:quantity].to_i
    flash[:success] = t ".success"
    redirect_to carts_path
  end

  def try_out_params
    return if params[:quantity].present?
    flash[:danger] = t ".not_quantity"
    redirect_to carts_path
  end
end
