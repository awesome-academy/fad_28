module ProductsHelper
  def load_category
    Category.all.map{|c| [c.name, c.id]}
  end

  def display_discount_for product
    if product.discount == product.discount.to_i
      - product.discount.to_i
    else
      - product.discount
    end
  end

  def discount_for product
    product.price * (100 - product.discount) / 100
  end
end
