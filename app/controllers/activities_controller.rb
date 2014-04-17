class ActivitiesController < ApplicationController

  def index

    trip = Trip.find(params[:trip_id])
    activities = trip.activities
    render :json => {:trip => trip, :activities => activities}

  end

  def create
    params[:activity][:thumbnail_photo] = "http://i.imgur.com/tCDTHfY.gif" if params[:activity][:thumbnail_photo] == nil
    trip = Trip.find(params[:trip_id])
    new_activity = trip.activities.new(activity_params)

    if new_activity.save
      render :json => { 
        :new_activity => new_activity,
        :success => "Activity Created!" 
      }
    end

  end

  def show

    trip = Trip.find(params[:trip_id])
    activity = trip.activities.find(params[:id])

    render :json => {:trip => trip, :activity => activity}

  end

  def update

    activity = Trip.find(params[:trip_id]).activities.find(params[:id])
    activity.update_attributes(activity_params)

    render :json => {
      :updates => activity,
      :success => 'Activity Updated!'
    }
  end

  def destroy

    activity = activity = Trip.find(params[:trip_id]).activities.find(params[:id])
    if activity.destroy

      render :json => {
        :success => 'Activity Deleted!'
      }

    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :address, :phone, :biz_url, :thumbnail_photo, :rating, :yid, :completed )
  end
  
end
