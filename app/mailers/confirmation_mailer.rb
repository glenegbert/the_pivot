class ConfirmationMailer < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def confirmation_email(user)
    @user = user
    mail(to: @user.email_address, subject: "order confirmation" )
  end
end
