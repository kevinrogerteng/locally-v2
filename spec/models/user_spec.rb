require 'spec_helper'

describe User do
  it {should have_many(:trips)}
  it 'is invalid without an email address'
  it 'is invalid without a screen name'
end
