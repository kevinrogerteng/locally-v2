require 'spec_helper'

describe "User" do

  describe "GET request for user profile page at /user/id.json" do 

    context 'given a user id' do

      before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
      end

      it 'should be successful' do
        get user_path(@user)
        response.status.should == 200
      end

      it 'should include user email address' do
        json = { :format => 'json'}
        get user_path(@user), json
        result = JSON.parse(response.body)
        result["email"].should eq("sample@example.com")
      end

    end
    
  end

  describe "POST JSON with /posts.json on create method" do
    
    it 'should be successful' do
      post users_path user: {email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password"}
      response.status.should == 200
    end

  end

  describe "DELETE JSON with /posts.json on destroy method" do

    before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    end

    it 'should be successful' do
      json = { :format => 'json'}
      delete user_path @user, json
      response.status.should == 200
    end

  end

end