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

  def caculate_rating sum_star, count_rating
    (sum_star.to_f / count_rating).round(1) if sum_star.present?
  end
end
