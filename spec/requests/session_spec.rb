require 'spec_helper'

describe 'Session' do  
  before :each do
    @user = create(:user, password: "password", password_confirmation: "password")
  end 

  describe 'POST JSON with /sessions.json' do

    it 'should be successful' do
      post sessions_path session: {email: @user.email, password: "password"}
      response.status.should == 200
    end

    it 'should return a user' do
      post sessions_path session: {email: @user.email, password: "password"}
      result = JSON.parse(response.body)
      result['success']['email'].should eq(@user.email)
    end

    it 'should NOT return password_digest' do
      post sessions_path session: {email: @user.email, password: "password"}
      result = JSON.parse(response.body)
      result['success']['password_digest'].should eq(nil)
    end

    it 'should NOT return remember_token' do
      post sessions_path session: {email: @user.email, password: "password"}
      result = JSON.parse(response.body)
      result['success']['remember_token'].should eq(nil)
    end
  end

  describe 'DESTROY JSON with /sessions.json' do
      it 'should be successful' do
      delete session_path @user
      response.status.should == 200
    end
  end

end