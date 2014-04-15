class User < ActiveRecord::Base

  has_many :trips, dependent: :destroy

  has_secure_password
  before_save :create_remember_token

  validates :screen_name, uniqueness: true, presence: true
  validates :email, uniqueness: true,  presence: true
  validates :password, confirmation: true, length: {in: 6..20}
  validates :password_confirmation, presence: true

  def self.authenticate(email_address, password)
    user = find_by_email(email_address)
    return user if user && user.authenticate(password)
  end

  private

  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end

end
