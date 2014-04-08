class User < ActiveRecord::Base
  has_many :trips
  has_secure_password

  def self.authenticate(email_address, password)
    user = find_by_email(email_address)
    return user if user && user.authenticate(password)
  end

end
