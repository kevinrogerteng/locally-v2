class TripsController < ApplicationController

  def index

    trips = Trip.where(user_id: params[:id])

    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json => trips.as_json(:include => [:user])}
        #f.json {render :json => @posts.as_json(:include=> [:tickets, :user])}
    end

  end
end
