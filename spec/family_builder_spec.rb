require 'spec_helper'
require_relative '../lib/family_builder.rb'
require_relative '../lib/relationship_manager.rb'

describe FamilyBuilder do
    # checks against seed data, gramps is head of family

  context 'people have parents' do
    before do
      @relative = Person.create(:first_name => 'suzy')
      @person = FactoryGirl.create :person
      @person1 = FactoryGirl.create :person
      @person2 = FactoryGirl.create :person
      @person3 = FactoryGirl.create :person
      @person4 = FactoryGirl.create :person
      @person.save
      RelationshipManager.new(@relative, @person1, 'Parent')
      RelationshipManager.new(@person1, @person2, 'Parent')
      RelationshipManager.new(@person2, @person3, 'Parent')
      RelationshipManager.new(@person3, @person4, 'Parent')
    end

    it 'should return parents' do
      relation = RelationshipManager.new(@person, @relative, 'Child')
      RelationshipManager.get_parents(@person).should == @relative
    end

    it 'should return head of family' do
      FamilyBuilder.head_of_family(@person4).first_name.should == 'suzy'
    #  person2 = FactoryGirl.create :person
    #  FamilyBuilder.head_of_family(person2).first_name.should_not == 'gramps'
    end
  end
end


