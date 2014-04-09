class TripsController < ApplicationController

  def index

    # trips = Trips.where(user_id: params[:id])

    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json}
        #f.json {render :json => @posts.as_json(:include=> [:tickets, :user])}
    end

  end
end
