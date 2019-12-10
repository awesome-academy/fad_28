class AdminController < ApplicationController
  before_action :authenticate_user!, :only_admin, :count_users

  def index
    @count_categories = Category.count
    @count_products = Product.count
  end

  def orders_by_day
    count_and_caculate_order Order.finish.group_by_day(:created_at)
  end

  def orders_by_week
    count_and_caculate_order Order.finish.group_by_week(:created_at)
  end

  def orders_by_month
    count_and_caculate_order Order.finish.group_by_month(:created_at)
  end

  def orders_by_year
    count_and_caculate_order Order.finish.group_by_year(:created_at)
  end

  def trash
    @trash_products = Product.only_deleted.paginate page: params[:page],
      per_page: Settings.items
  end

  private

  def count_and_caculate_order group_by_time
    @count_orders = group_by_time.count
    @total_price = group_by_time.joins(:order_items).sum "quantity * price"
  end

  def count_users
    @count_users = User.count
  end
end
