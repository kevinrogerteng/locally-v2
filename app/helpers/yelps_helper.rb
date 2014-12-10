module YelpsHelper

  # for now, making controller skinny.
  # TODO: Make this into a mixin?

  def yelp_api destination, restaurant

    location = destination.delete(",").gsub(" ", "+")
    consumer_key = ENV['CONSUMER_KEY']
    consumer_secret = ENV['CONSUMER_SECRET']
    token = ENV['TOKEN']
    token_secret = ENV['TOKEN_SECRET']

    api_host = 'api.yelp.com'
    offset_number = rand(10)

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    path = "/v2/search?term=#{restaurant}&location=#{location}&limit=6&offset=#{offset_number}"
    parsed_results = JSON.parse(access_token.get(path).body)["businesses"]

    results = []
  
    parsed_results.each do |result|
        object = {"name" => "#{result['name']}", 
        "display_phone" => "#{result['display_phone']}",
        "thumbnail_photo" => "#{result['image_url']}",
        "biz_url" => "#{result['url']}",
        "rating" => "#{result['rating']}",
        "address" => "#{result['location']['address'].first}, #{result['location']['city']}, #{result['location']['country_code']}, #{result['location']['postal_code']}",
        "rating" => "#{result['rating']}",
        "yid" => "#{result['id']}"
        }
        results.push object
    end
    return results
  end

end
