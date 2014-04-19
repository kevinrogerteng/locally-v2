require 'spec_helper'

describe "Yelp" do

  describe "GET JSON with /api/yelp.json on YELP_SEARCH method" do
    it 'should be successful' do
      get yelp_search_path params: {destination: "San Francisco"}
      response.status.should == 200
    end
  end

end