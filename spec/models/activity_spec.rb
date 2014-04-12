require 'spec_helper'

describe Activity do
  
  it 'has a valid factory' do
    create(:activity).should be_valid
  end

  it 'has a name' do
    FactoryGirl.build(:activity, name: nil).should_not be_valid
  end

  it {should belong_to(:trip)}

  it 'has completed as default upon creation' do
    activity = FactoryGirl.build(:activity)
    expect(activity.completed).to eq(false)
  end
  
end