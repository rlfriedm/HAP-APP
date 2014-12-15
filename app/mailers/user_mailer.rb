class UserMailer < ActionMailer::Base
  default :from => "hamcoladkp@gmail.com"
  def forgot_password(user)
  		tmp = SecureRandom.urlsafe_base64
  		@other = tmp[0..10]
  		user.password = @other
  		user.save
  		mail(:to => user.email, :subject => "Password")
  end
end
