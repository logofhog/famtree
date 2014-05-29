require 'spec_helper'
require_relative '../lib/family_builder.rb'
require_relative '../lib/relationship_manager.rb'

describe FamilyBuilder do
    # checks against seed data, gramps is head of family

  context 'people have parents' do
    before do
      @person = FactoryGirl.create :person
      @relative = Person.create(:first_name => 'suzy')
    end

    it 'should return parents' do
      relation = RelationshipManager.new(@person, @relative, 'Child')
      RelationshipManager.get_parents(@person).should == @relative
    end
  end

  it 'should return head of family' do
    person = Person.all.last
    FamilyBuilder.head_of_family(person).first_name.should == 'gramps'
  #  person2 = FactoryGirl.create :person
  #  FamilyBuilder.head_of_family(person2).first_name.should_not == 'gramps'
  end
end


