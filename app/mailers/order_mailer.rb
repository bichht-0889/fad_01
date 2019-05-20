class OrderMailer < ApplicationMailer
  def order_confirm order
    @order = order
    mail to: User.admin.pluck(:email), subject: t("mailers.order.order_confirm")
  end

  def order_info order
    @order = order
    mail to: order.user.email, subject: t("mailers.order.order_info")
  end
end
