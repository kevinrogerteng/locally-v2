require 'spec_helper'

describe "Trip" do

  before (:each) do 
    @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    @trip = create(:trip, user_id: @user.id)
  end

  describe "GET JSON with /trips.json ON index method"

    it "should be successful" do
      get trips_path
      response.status.should == 200
    end

    it "should respond as JSON" do
      json = { :format => 'json'}
      get trips_path, json
      result = JSON.parse(response.body)
      result.should be_kind_of Array
      result.length.should_not be_nil
    end

    it "should return trip(s) that belongs to the signed in user" do
      json = { :format => 'json'}
      id = {:id => @user.id}
      get trips_path(id), json
      result = JSON.parse(response.body)
      result.first['user']['email'].should eq(@user.email)
    end

end