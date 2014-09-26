class User < ActiveRecord::Base
  attr_accessor    :password
  attr_accessible :email, :username, :password#, :password_confirmation

  email_regex = /.+@hamilton.edu/i
  validates :username, 	:presence => true,
  						:length => {:maximum => 15}, 
  						:length => {:minimum => 3}, 
  						:uniqueness => {:case_sensitive => false}

  validates :email, :presence => true,
  					:length => {:maximum => 50},
  					:format => {:with => email_regex},
  					:uniqueness => {:case_sensitive => false}

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:maximum => 50}, 
                       :length => {:minimum => 5}

  before_save :encrypt_password

  def User.authenticate(email, submitted_password)
    user = User.find_by_email(email)
    return nil if user.nil
    return user if user.has_password(submitted_password)
  end

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  private

    def encrypt_password
      self.salt = make_salt if self.new_record?
      self.encrypted_password = encrypt(self.password)
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
