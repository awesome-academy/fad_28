class HomeController < ApplicationController
  def index
    @newests = Product.newest.limit Settings.tops
    @promotions = Product.is_discount.newest.limit Settings.tops
    @highlights = Product.is_highlight.newest.limit Settings.tops
  end
end
