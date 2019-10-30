class UserMailer < ApplicationMailer
  def reset_password user
    @user = user
    mail to: user.email, subject: t(".reset")
  end
end
