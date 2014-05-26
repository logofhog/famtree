require 'spec_helper'
require_relative '../lib/family_builder.rb'
require_relative '../lib/relationship_manager.rb'

describe FamilyBuilder do
  it 'should return head of family' do
    # checks against seed data, fred is head of family
    family = Family.first
  end

  it 'should return parents' do
    person = FactoryGirl.create :person
    relative = Person.create(:first_name => 'suzy')
    relation = RelationshipManager.new(person, relative, 'Child')
    RelationshipManager.get_parents(relative).should == person
  end

  it 'should return head of family' do
  end

end


