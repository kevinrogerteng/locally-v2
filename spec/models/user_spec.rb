require 'spec_helper'

describe User do
  it 'has a valid factory' do
    create(:user).should be_valid
  end

  it 'authenticates with matching email and password' do
    user = create(:user, email: "sample@example.com" ,password: "password", password_confirmation: "password")
    User.authenticate("sample@example.com", "password").should eq(user)
  end

  it 'checks to see if password is confirmed'

  it 'does not authenticate with incorrect password'

  it 'is invalid without an email address'
  it 'is invalid without a screen name'
  it {should have_many(:trips)}
end
