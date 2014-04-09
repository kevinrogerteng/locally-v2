require 'spec_helper'

describe "User" do
  before (:each) do 
    @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
  end

  describe "GET request for user profile page at /user/id.json" do 
    it 'should be successful'
    it 'should include user name'
  end

  describe "POST request for user sign-up at /user.json" do
    it 'should be successful'
  end

end