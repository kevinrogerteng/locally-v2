class TripsController < ApplicationController

  def index

    trips = Trip.where(user_id: params[:current_user])
    user = User.find(params[:current_user])

    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json => {
          :trips => trips,
          :user => user
          }
        }
    end
  end

  def create

    new_trip = Trip.new(trip_params)

    if new_trip.save
      render :json => {
        :success => "Trip Created",
        :new_trip => new_trip
      }
    end
  end

  def show
    trip = Trip.find(params[:id])

    respond_to do |f|
      f.html {render :layout => false}
      f.json {render :json => trip.as_json(:include => [:activities])}
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    if trip.destroy
      render :json => {:success => "Trip Deleted"}
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :destination, :description, :completed, :user_id)
  end
end
