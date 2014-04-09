require 'spec_helper'

describe "Session" do

  it 'should be successful' do
    get new_session_path
    response.should be_successful
  end

  # THIS IS MORE FOR BDD
  # describe "Signing in" do
  #   context "with correct credentials" do
  #     it 'should create a remember token'
  #     it 'should set current user'
  #   end

  #   context "with incorrect credentials" do
  #     it 'should return an error'
  #   end
  # end
  
end