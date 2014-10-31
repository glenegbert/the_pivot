class WelcomeMailer < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email_address, subject: "Welcome to Dope Threads" )
  end
end
