module UsersHelper
  def gender_for user
    if user.gender
      t ".male"
    elsif user.gender == false
      t ".female"
    end
  end

  def load_role
    User.role_ids.keys
  end

  def count_quantity_ordered_for user
    finished = Order.finish.by_user user.email
    finished.reduce(0){|a, e| a + e.order_items.sum(:quantity)}
  end
end
