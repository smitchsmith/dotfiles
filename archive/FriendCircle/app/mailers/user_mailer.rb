class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def forgot_password(user)
    @user = user
    @url = reset_password_page_url(user.reset_token, host: "localhost:3000")
    mail(to: user.email, subject: "Reset Password")
  end
end