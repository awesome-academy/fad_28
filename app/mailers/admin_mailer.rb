class AdminMailer < ApplicationMailer
  default to: ->{User.admin.pluck :email}

  def notice_admin order
    @order = order
    mail subject: t(".notice")
  end
end
