require 'spec_helper'

describe User do

  it 'has a valid factory' do
    create(:user).should be_valid
  end

  it 'authenticates with matching email and password' do
    user = create(:user, email: "sample@example.com" ,password: "password", password_confirmation: "password")
    User.authenticate("sample@example.com", "password").should eq(user)
  end

  it 'does not authenticate with incorrect password' do
    create(:user, email: "sample@example.com" ,password: "password", password_confirmation: "password")
    User.authenticate("sample@example.com", password: "incorrect")
  end

  it 'is invalid without an email address' do
    FactoryGirl.build(:user, email: nil, screen_name: "pengusan", password: "password", password_confirmation: "password").should_not be_valid
  end

  it 'is invalid without a screen name' do 
    FactoryGirl.build(:user, email: "sample@example.com", screen_name: nil, password: "password", password_confirmation: "password").should_not be_valid
  end

  it 'validates uniqueness of email address' do
    create(:user, email: "sample@example.com" ,password: "password", password_confirmation: "password")
    new_user = User.new( email: "sample@example.com",password: "password", password_confirmation: "password")
    expect(new_user).to have(1).errors_on(:email)
  end

  it 'validates uniqueness of screen name' do
    create(:user, email: "sample@example.com" ,screen_name: "pengusan", password: "password", password_confirmation: "password")
    new_user = User.new( email: "anothersample@example.com", screen_name: "pengusan", password: "password", password_confirmation: "password")
    expect(new_user).to have(1).errors_on(:screen_name)
  end

  it {should have_many(:trips).dependent(:destroy)}

end
