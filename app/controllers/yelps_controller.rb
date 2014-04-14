class YelpsController < ApplicationController

  def yelp_search

    restaurant = 'restaurant'
    trip = "San Francisco"
    offset_number = 10

    location = trip.delete(",").gsub(" ", "+")
    consumer_key = ENV['CONSUMER_KEY']
    consumer_secret = ENV['CONSUMER_SECRET']
    token = ENV['TOKEN']
    token_secret = ENV['TOKEN_SECRET']

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    path = "/v2/search?term=#{restaurant}&location=#{location}&limit=10&sort=0&offset=#{offset_number}"
    result = JSON.parse(access_token.get(path).body)["businesses"]
    if result.nil? || result == "" || result.empty?
      render :json => {}
    else 
      render :json => result
    end
  end

end
