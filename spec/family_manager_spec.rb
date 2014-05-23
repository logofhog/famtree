require 'spec_helper'
require_relative '../lib/family_builder.rb'

describe FamilyBuilder do

  it 'should work' do
    person = FactoryGirl.create :person
    family = FactoryGirl.create :family
  end

end

