module ProductsHelper
  def load_category
    @categories.map{|c| [c.name, c.id]}
  end

  def display_discount_for product
    return 0 if product.discount.nil?
    if product.discount == product.discount.to_i
      product.discount.to_i
    else
      product.discount
    end
  end

  def price_for product
    return product.price if product.discount.nil?
    product.price * (100 - product.discount) / 100
  end

  def new_suggest
    Suggest.not_seen.size
  end
end
