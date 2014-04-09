require 'spec_helper'

describe Trip do

  it 'has a valid factory' do
    create(:trip).should be_valid
  end

  it 'should validate presence of name' do
    FactoryGirl.build(:trip, name: nil).should_not be_valid
  end

  it 'should validate presence of destination' do
    FactoryGirl.build(:trip, destination: nil).should_not be_valid
  end

  it 'should set completed attribute to false upon creation' do
    new_trip = FactoryGirl.build(:trip)
    expect(new_trip.completed).to eq(false)
  end

  it {should belong_to(:user)}

  it {should have_many(:activities).dependent(:destroy)}

end
