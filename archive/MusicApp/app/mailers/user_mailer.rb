class UserMailer < ActionMailer::Base
  default from: "me@mitchellzsmith.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Howdy')
  end
end
