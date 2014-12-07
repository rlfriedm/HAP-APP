
ActionMailer::Base.smtp_settings = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => 'hamcoladkp@gmail.com',
  :password             => '123.abc.',
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}