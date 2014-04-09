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
        #f.json {render :json => @posts.as_json(:include=> [:tickets, :user])}
    end
  end

  def show

    trip = Trip.find(params[:id])

    respond_to do |f|
      f.html {render :layout => false}
      f.json {render :json => trip.as_json(:include => [:activities])}
      #f.json {render :json => @posts.as_json(:include=> [:tickets, :user])}
    end

  end
end
