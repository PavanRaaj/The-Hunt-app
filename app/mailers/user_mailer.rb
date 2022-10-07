class UserMailer < ActionMailer::Base
    default :from => "thehuntapp.helpdesk@gmail.com"
# confirmation mail on signup 
 def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Registration Confirmation")
 end

# reset token on password reset. 
 def forgot_password(user)
   @user = user
   @greeting = "Hello"
   
   mail to: @user.email, :subject => 'Reset password instructions'
 end

end