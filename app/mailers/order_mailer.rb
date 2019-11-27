class OrderMailer < ApplicationMailer
  def notice_customer order
    @order = order
    mail to: order.email, subject: t(".thank")
  end

  def notice_transport order
    @order = order
    mail to: order.email, subject: t(".transporting")
  end

  def notice_finished order
    @order = order
    mail to: order.email, subject: t(".finished")
  end
end
