require 'spec_helper'

describe "Activity" do

  before :each do
    @user = create(:user, email: "sample@example.com", screen_name: "pengusan" ,password: "password", password_confirmation: "password")
    @trip = create(:trip, user_id: @user.id)
    @activity = create(:activity, trip_id: @trip.id)
  end

    describe 'GET JSON with trips/trip_id/activities.json on INDEX method' do

      before :each do
        json = { :format => 'json'}
        get trip_activities_path(@trip), json
      end

       it 'should be successful' do
        response.status.should == 200
       end

       it 'should return trips' do
        result = JSON.parse(response.body)
        result['trip']['name'].should eq(@trip.name)
       end

       it 'should return the activities of that trip' do
        result = JSON.parse(response.body)
        result['activities'].should_not be_nil
       end

    end
  
    describe 'GET JSON with trips/trip_id/activities/:id.json on SHOW method' do
    
      it 'should be successful' do
        json = {:format => 'json'}
        get trip_activity_path @trip, @activity, json
        response.status.should == 200
      end

      it 'should return the trip' do
        json = {:format => 'json'}
        get trip_activity_path @trip, @activity, json
        result = JSON.parse(response.body)
        result['trip'].should_not be_nil
      end

      it 'should return the activity of that trip' do
        json = {:format => 'json'}
        get trip_activity_path @trip, @activity, json
        result = JSON.parse(response.body)
        result['activity']['name'].should eq(@activity.name)
      end
    end

    describe 'POST JSON with trips/trip_id/activities.json on CREATE method' do

      it 'should be successful' do
        post trip_activities_path @trip, activity: {name: "Activity Name", description: "some description", address: 'some address', display_phone: 'some display_phone'}
        response.status.should == 200
      end

      it 'should return the new activity as JSON' do
        post trip_activities_path @trip, activity: {name: "Activity Name", description: "some description", address: 'some address', display_phone: 'some display_phone'}
        result = JSON.parse(response.body)
        result['new_activity']['name'].should eq("Activity Name")
      end


      it 'should return a success message' do
        post trip_activities_path @trip, activity: {name: "Activity Name", description: "some description", address: 'some address', display_phone: 'some display_phone'}
        result = JSON.parse(response.body)
        result['success'].should eq("Activity Created!")

      end

    end

    describe 'PATCH JSON with trips/:trip_id/activities/:id.json on UPDATE method' do
      context 'given a trip id and an activity id' do
        before :each do
          @params = {}
          @params[:name] = "some new name"
          patch trip_activity_path @trip, @activity, :activity => @params.as_json
        end

        it 'should be successful' do
          response.status.should == 200
        end

        it' should persist updates' do
          result = JSON.parse(response.body)
          result['updates']['name'].should eq('some new name')
        end

        it 'should return a success message' do
          result = JSON.parse(response.body)
          result['success'].should eq('Activity Updated!')
        end
      end
    end

    describe 'DESTROY JSON with trips/:trip_id/activities/:id.json on DESTROY method' do

      context 'given a trip id and an activity id' do
        before :each do
          delete trip_activity_path @trip, @activity
        end

        it 'should be successful' do
          response.status.should == 200
        end

        it' should return a success message' do
          result = JSON.parse(response.body)
          result["success"].should eq('Activity Deleted!')
        end

      end
    end
end