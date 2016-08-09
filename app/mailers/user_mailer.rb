class UserMailer < ApplicationMailer

	default from: 'mayas09041993@gmail.com'
 
  def welcome_email(user, password)
    @user = user
    @password = password
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to 7 nodes Payroll Management System')
  end
  
end
