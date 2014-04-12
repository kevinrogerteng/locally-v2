require 'spec_helper'

describe "Trip" do

  before :each do 
    @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    @trip = create(:trip, user_id: @user.id)
  end

  describe "GET JSON with /trips.json ON index method" do

    before :each do
      id = {:current_user => @user.id}
      json = { :format => 'json'}
      get trips_path(id), json
    end

    it "should be successful" do
      response.status.should == 200
    end

    it "should respond as JSON" do
      result = JSON.parse(response.body)
      result.should be_kind_of Hash
      result.length.should_not be_nil
    end

    it "should return trip(s) that belongs to the signed in user" do
      result = JSON.parse(response.body)
      result['user']['email'].should eq(@user.email)
    end

  end

  describe "GET JSON with /trips/:id.json ON show method" do

    before :each do
      json = { :format => 'json'}
      get trip_path @trip, json
    end

    it 'should be successful' do
      response.status.should == 200
    end

    it 'should respond as JSON' do
      result = JSON.parse(response.body)
      result.should be_kind_of Hash
      result.length.should_not be_nil
    end

    it 'should return the selected trip as JSON' do
      result = JSON.parse(response.body)
      result['name'].should eq(@trip.name)
    end

    it 'should return activities' do
      result = JSON.parse(response.body)
      result['activities'].should_not be_nil
      result['activities'].should be_kind_of Array
    end

  end

  describe "POST JSON with /trips.json ON create method" do

    before :each do
      post trips_path trip: {name: "First Trip", destination: "San Francisco", desciption: "some desciption", user_id: @user.id}
    end

    it 'should be successful' do
      response.status.should == 200
    end

    it 'should return the new trip as JSON' do
      result = JSON.parse(response.body)
      result['new_trip']['name'].should eq('First Trip')
    end

    it 'should return a success message as JSON' do
      result = JSON.parse(response.body)
      result['success'].should eq('Trip Created')
    end

    it 'should be created with completed as false' do
      result = JSON.parse(response.body)
      result['new_trip']['completed'].should be_false
    end

  end

  describe "PATCH JSON with /trips/:id.json on UPDATE method" do
    context "Given a trip id" do

      before :each do
        @params = {}
        @params[:name] = "some new name"
        patch trip_path @trip, :trip => @params.as_json
      end

      it 'should be successful' do
        response.status.should == 200
      end

      it 'should persist updates' do
        result = JSON.parse(response.body)
        result['updates']['name'].should eq('some new name')
      end

      it 'should return a sucess message' do
        result = JSON.parse(response.body)
        result['success'].should eq('Trip Updated!')
      end
    end
  end

  describe "DELETE JSON with /trips.json on DESTROY method" do

    before :each do
      json = { :format => 'json'}
      delete trip_path @trip, json
    end
    it 'should be successful' do
      response.status.should == 200
    end

    it 'should return success message' do
      result = JSON.parse(response.body)
      result['success'].should eq("Trip Deleted")
    end
  end

end



