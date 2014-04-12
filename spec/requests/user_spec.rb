require 'spec_helper'

describe "User" do

  describe "GET request for user profile page at /user/id.json" do 

    context 'given a user id' do

      before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
        json = { :format => 'json'}
        get user_path(@user), json
      end

      it 'should be successful' do
        response.status.should == 200
      end

      it 'should include user email address' do
        result = JSON.parse(response.body)
        result["email"].should eq("sample@example.com")
      end

    end
    
  end

  describe "POST JSON with /users.json on create method" do

    before :each do
      post users_path user: {email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password"}
    end
    
    it 'should be successful' do
      response.status.should == 200
    end

    it 'should create a new user' do
      result = JSON.parse(response.body)
      result['success'].should eq("Welcome!")

    end

  end

  describe "PATCH JSON with /users/id.json" do

    context 'given a user id' do

      before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
        @params = {}
        @params[:hometown] = "San Francisco"
        @params[:screen_name] = "pandasan"
        patch user_path @user.id, :user => @params.as_json
      end

      it 'should be successful' do
        @user.reload
        response.status.should == 200
      end

      it 'should return a success message' do
        result = JSON.parse(response.body)
        result['success'].should eq("Account Updated")
      end

      it 'should persist the updates' do
        result = JSON.parse(response.body)
        result["updates"]["hometown"].should eq("San Francisco")
      end

    end
  end

  describe "DELETE JSON with /users.json on destroy method" do

    before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
        json = { :format => 'json'}
        delete user_path @user, json
    end

    it 'should be successful' do
      response.status.should == 200
    end

    it 'should return a success message' do
      result = JSON.parse(response.body)
      result['success'].should eq("Account deleted")
    end

  end

end