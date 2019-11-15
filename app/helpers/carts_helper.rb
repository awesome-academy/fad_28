module CartsHelper
  def sum_of_each_item quantity, price
    quantity * price
  end

  def load_payment
    @payments.map{|pm| [pm.name, pm.id]}
  end

  def load_size_cart
    session[:cart].size
  end
end
