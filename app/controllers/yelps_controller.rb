class YelpsController < ApplicationController

  def yelp_search

    restaurant = 'restaurant'
    trip = "San Francisco"
    offset_number = 1

    location = trip.delete(",").gsub(" ", "+")
    consumer_key = ENV['CONSUMER_KEY']
    consumer_secret = ENV['CONSUMER_SECRET']
    token = ENV['TOKEN']
    token_secret = ENV['TOKEN_SECRET']

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    path = "/v2/search?term=#{restaurant}&location=#{location}&limit=2&sort=0&offset=#{offset_number}"
    parsed_results = JSON.parse(access_token.get(path).body)["businesses"]

    results = []

    parsed_results.each do |result|
        object = {"name" => "#{result['name']}", 
        "display_phone" => "#{result['display_phone']}",
        "image_url" => "#{result['image_url']}",
        "url" => "#{result['url']}",
        "rating" => "#{result['rating']}",
        "location" => "#{result['location']['address'].first}, #{result['location']['city']}, #{result['location']['country_code']}, #{result['location']['postal_code']}",
        "rating" => "#{result['rating']}"
        }

        results.push object
    end

    

    if results.nil? || results == "" || results.empty?
      render :json => {}
    else 
      render :json => results
    end
  end

end
