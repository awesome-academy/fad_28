class StoresController < ApplicationController
  before_action :load_category
  before_action :load_search_products

  def index; end

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

  def load_search_products
    @search = Product.ransack params[:q]
    @products = @search.result.paginate page: params[:page],
      per_page: Settings.items
  end
end
