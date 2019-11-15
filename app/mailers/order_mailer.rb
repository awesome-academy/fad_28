class OrderMailer < ApplicationMailer
  def notice_customer order
    @order = order
    mail to: order.email, subject: t(".thank")
  end
end
