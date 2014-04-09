class User < ActiveRecord::Base
  has_many :trips
  has_secure_password

  validates :screen_name, uniqueness: true, presence: true
  validates :email, uniqueness: true,  presence: true
  validates :password, confirmation: true, length: {in: 6..20}
  validates :password_confirmation, presence: true

  def self.authenticate(email_address, password)
    user = find_by_email(email_address)
    return user if user && user.authenticate(password)
  end

end
