class StoresController < ApplicationController
  before_action :load_category
  before_action :load_product, :by_name, :by_min_price, :by_max_price,
    :by_category, :by_highlight, :by_discount, only: :index

  def index
    @products = @products.paginate page: params[:page], per_page: Settings.items
  end

  def food
    food = Category.find_by name: "food"
    return unless food
    result = Product.joins(:category).get_category food.id
    @foods = result.paginate page: params[:page], per_page: Settings.items
  end

  def drink
    drink = Category.find_by name: "drink"
    return unless drink
    result = Product.joins(:category).get_category drink.id
    @drinks = result.paginate page: params[:page], per_page: Settings.items
  end

  private

  def load_product
    @products = Product.all
  end

  def by_name
    @products = @products.joins(:category).search_by params[:name] if
      params[:name].present?
  end

  def by_min_price
    @products = @products.min_price params[:min_price] if
      params[:min_price].present?
  end

  def by_max_price
    @products = @products.max_price params[:max_price] if
      params[:max_price].present?
  end

  def by_category
    @products = @products.joins(:category).get_category params[:category_id] if
      params[:category_id].present?
  end

  def by_highlight
    @products = @products.is_highlight if params[:sold_many] == Settings.checked
  end

  def by_discount
    @products = @products.is_discount if params[:discount] == Settings.checked
  end
end
