class OrdersController < ApplicationController
  before_action :signed_in
  before_action :only_admin, :load_order_places, :load_order_transports,
    :load_order_finishes, only: :index
  before_action :load_payment, except: [:index, :show]
  before_action :load_order, except: [:index, :new, :create]
  before_action :load_order_items, :calculate_total,
    :allow_view_detail_order, only: :show
  before_action :allow_edit_and_destroy, only: [:edit, :update, :destroy]

  def index; end

  def show; end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new order_params
    begin
      ActiveRecord::Base.transaction do
        @order.save
        save_order_items @cart, @order
        @order.send_email_for_customer
        @order.send_email_for_admin
        session.delete :cart
        flash[:success] = t ".success"
        redirect_to root_path
      end
    rescue StandardError
      flash[:danger] = t ".fail"
      redirect_to root_path
    end
  end

  def update
    if @order.update order_params
      flash[:success] = t ".success"
      redirect_to current_user
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to current_user
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def load_payment
    @payments = Payment.all
  end

  def save_order_items cart, order
    all_items = []
    cart.each do |key, value|
      product = Product.find_by id: key
      price = price_for product
      all_items.push({product_id: key.to_i, quantity: value, price: price})
    end
    order.order_items.create(all_items)
  end

  def allow_view_detail_order
    user = User.find_by email: @order.email
    return if current_user == user || current_user.admin?
    flash[:danger] = t ".can't_view"
    redirect_to current_user
  end

  def allow_edit_and_destroy
    user = User.find_by email: @order.email
    return if current_user == user && @order.place?
    flash[:danger] = t ".can't"
    redirect_to current_user
  end

  def load_order_places
    @places = Order.place.newest.paginate page: params[:page],
      per_page: Settings.items
  end

  def load_order_transports
    @transports = Order.transport.newest.paginate page: params[:page],
      per_page: Settings.items
  end

  def load_order_finishes
    @finishes = Order.finish.newest.paginate page: params[:page],
      per_page: Settings.items
  end

  def load_order_items
    @order_items = @order.order_items.includes(:product)
  end

  def load_order_items
    @order_items = @order.order_items.includes(:product)
  end

  def calculate_total
    @total = @order_items.reduce(0) do |sum, item|
      sum + item.quantity * item.price
    end
  end
end
