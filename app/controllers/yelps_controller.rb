class YelpsController < ApplicationController
    include YelpsHelper

    def yelp_search
        if params[:restaurant] != nil
            restaurant = params[:restaurant].gsub(" ", "+")
        else
            restaurant = "restaurant"
        end

        results = search_yelp(params[:destination], restaurant)

        if results.nil? || results == "" || results.empty?
          render :json => {}
        else 
          render :json => results
        end
    end
    
end
