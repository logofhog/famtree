 require 'spec_helper'

describe Person do
  it 'should create a person' do
    person = FactoryGirl.create :person
    person.first_name.should == 'factfred'
  end

  it 'should add user to a family' do

  end

  it 'should add relationship' do
  end

end

describe Person do
  it 'should do this' do
  end
end
