# http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password
    user = User.first
    user.reset_password_token = user.new_token
    UserMailer.reset_password user
  end
end
