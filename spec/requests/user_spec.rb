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

  describe "POST JSON with /users.json on create method" do
    
    it 'should be successful' do
      post users_path user: {email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password"}
      response.status.should == 200
    end

    it 'should create a new user' do
      post users_path user: {email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password"}
      result = JSON.parse(response.body)
      result['success'].should eq("Welcome!")

    end

  end

  describe "PATCH JSON with /users/id.json" do

    context 'given a user id' do

      before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
        @params = {}
      end

      it 'should be successful' do
        @params[:hometown] = "San Francisco"
        @params[:screen_name] = "pandasan"
        patch user_path @user.id, :user => @params.as_json
        @user.reload
        response.status.should == 200
      end

      it 'should return a success message' do
        @params[:hometown] = "San Francisco"
        @params[:screen_name] = "pandasan"
        patch user_path @user.id, :user => @params.as_json
        result = JSON.parse(response.body)
        result['success'].should eq("Account Updated")
      end

      it 'should persist the updates' do
        @params[:hometown] = "San Francisco"
        @params[:screen_name] = "pandasan"
        patch user_path @user.id, :user => @params.as_json
        result = JSON.parse(response.body)
        result["updates"]["hometown"].should eq("San Francisco")
      end

    end
  end

  describe "DELETE JSON with /users.json on destroy method" do

    before (:each) do 
        @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    end

    it 'should be successful' do
      json = { :format => 'json'}
      delete user_path @user, json
      response.status.should == 200
    end

    it 'should return a success message' do
      json = { :format => 'json'}
      delete user_path @user, json
      result = JSON.parse(response.body)
      result['success'].should eq("Account deleted")
    end

  end

end