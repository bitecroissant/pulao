class UserMailer < ApplicationMailer

  def welcome_email(code, email)
    @code = code
    mail(to: email, subject: '「蒲牢」验证码')
  end

end
