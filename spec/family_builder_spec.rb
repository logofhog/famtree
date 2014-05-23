require 'spec_helper'
require_relative '../lib/family_builder.rb'

describe FamilyBuilder do
  it 'should return head of family' do
    # checks against seed data, fred is head of family
    family = Family.first
  end
end


