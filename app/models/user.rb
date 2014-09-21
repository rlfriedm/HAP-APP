class User < ActiveRecord::Base
  attr_accessible :email, :username, :password

  email_regex = /.+@hamilton.edu/i
  validates :username, 	:presence => true,
  						:length => {:maximum => 15}, 
  						:length => {:minimum => 3}, 
  						:uniqueness => {:case_sensitive => false}

  validates :email, :presence => true,
  					:length => {:maximum => 50},
  					:format => {:with => email_regex},
  					:uniqueness => {:case_sensitive => false}


end
