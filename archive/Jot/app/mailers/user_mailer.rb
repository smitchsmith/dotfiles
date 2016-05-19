class UserMailer < ActionMailer::Base
  default from: "Mitch Smith <notifications@jot.com>"

  def welcome(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to Jot')
  end

  def comment(comment)
    @comment = comment
    @page = @comment.page

    mail(to: recipients, subject: "Jot Commented Upon!")
  end

  def favorite(page)
    @page = page
    mail(to: @page.owner.email, subject: "Jot Favorited!")
  end

  def share(page)
    @page = page
    mail(to: recipients, subject: "Jot Shared!")
  end

  def page(page)
    @page = page
    mail(to: recipients, subject: "Jot Updated!")
  end

  def password_reset(user)
    @user = user
    @token = user.password_reset
    mail(to: @user.email, subject: "Reset your Jot Password" )
  end

  # private

  def recipients
    _recipients = @page.shared_users.pluck(:email)
    _recipients << @page.owner.email if @page.owner
  end

end
