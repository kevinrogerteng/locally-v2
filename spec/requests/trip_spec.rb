require 'spec_helper'

describe "Trip" do

  before (:each) do 
    @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    @trip = create(:trip, user_id: @user.id)
  end

  describe "GET JSON with /trips.json ON index method" do

    it "should be successful for HTML" do
      id = {:current_user => @user.id}
      get trips_path(id)
      response.status.should == 200
    end

    it "should be successful for JSON" do
      json = { :format => 'json'}
      id = {:current_user => @user.id}
      get trips_path(id), json
      response.status.should == 200

    end

    it "should respond as JSON" do
      json = { :format => 'json'}
      id = {:current_user => @user.id}
      get trips_path(id), json
      result = JSON.parse(response.body)
      result.should be_kind_of Hash
      result.length.should_not be_nil
    end

    it "should return trip(s) that belongs to the signed in user" do
      json = { :format => 'json'}
      id = {:current_user => @user.id}
      get trips_path(id), json
      result = JSON.parse(response.body)
      result['user']['email'].should eq(@user.email)
    end

  end

  describe "GET JSON with /trips/:id.json ON show method" do

    it 'should be successful' do
      get trip_path(@trip)
      response.status.should == 200
    end

    it 'should respond as JSON' do
      json = { :format => 'json'}
      get trip_path(@trip), json
      result = JSON.parse(response.body)
      result.should be_kind_of Hash
      result.length.should_not be_nil
      response.status.should == 200
    end

    it 'should return the selected trip as JSON' do
      json = { :format => 'json'}
      get trip_path(@trip), json
      result = JSON.parse(response.body)
      result['name'].should eq(@trip.name)
    end

    it 'should return activities' do
      json = { :format => 'json'}
      get trip_path(@trip), json
      result = JSON.parse(response.body)
      result['activities'].should_not be_nil
      result['activities'].should be_kind_of Array
    end

  end

end