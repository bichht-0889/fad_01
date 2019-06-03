class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.user.account_activation")
  end

  def mail_month user, order
    @user = user
    @order = order
    mail to: User.admin.first.email, subject: t("mailers.user.statistical")
  end
end
