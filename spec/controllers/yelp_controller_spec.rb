require 'spec_helper'

describe YelpController do

  describe "GET 'yelp_search'" do
    it "returns http success" do
      get 'yelp_search'
      response.should be_success
    end
  end

end
