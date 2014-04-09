require 'spec_helper'

describe "Session" do

  it 'should be successful' do
    get new_session_path
    response.should be_successful
  end
  
end