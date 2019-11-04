module UsersHelper
  def gender_for user
    if user.gender
      t ".male"
    else
      t ".female"
    end
  end

  def load_role
    User.role_ids.keys
  end
end
