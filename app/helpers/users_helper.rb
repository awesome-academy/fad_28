module UsersHelper
  def gender_for user
    if user.gender
      t ".male"
    else
      t ".female"
    end
  end
end
