class ProductsController < ApplicationController
  before_action :signed_in, :only_admin, except: :show
  before_action :load_category, only: [:new, :edit]
  before_action :load_product, except: [:index, :new, :create]
  before_action :allow_destroy, only: :destroy

  def index
    product = Product.includes(:category)
    @products = product.filter_by(params[:name]).paginate page: params[:page],
      per_page: Settings.items
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to products_path
    else
      render :new
    end
  end

  def update
    if @product.update product_params
      flash[:success] = t ".success"
      redirect_to products_path
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to products_path
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".not_found"
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit :name, :image, :price, :discount,
      :sold_many, :description, :category_id, :close_discount_at
  end

  def allow_destroy
    exist_order_item = @product.order_items
    return if exist_order_item.empty?
    flash[:danger] = t ".fail"
    redirect_to products_path
  end
end
