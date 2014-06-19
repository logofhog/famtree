require_relative "../lib/relationship_manager.rb"
require 'spec_helper'

describe RelationshipManager do
  before do
    @person = create :person
  end

  include FactoryGirl::Syntax::Methods
  it 'should make a relationship' do
    person1 = Person.create(:first_name => 'burt')
    person2 = Person.create(:first_name => 'matt')
    rel = RelationshipManager.new(person2).make_relation(person1, 'Parent')
  end

  it 'should return relatives' do
    p1 = Person.create(:first_name => 'tony', :last_name => 'jones')
    p2 = Person.create(:first_name => 'burt', :last_name => 'jones')
    p3 = Person.create(:first_name => 'mike', :last_name => 'jones')
    p4 = Person.create(:first_name => 'joe', :last_name => 'jones')
    RelationshipManager.new(p1).make_relation(p2, 'Child')
    RelationshipManager.new(p1).make_relation(p3, 'Child')
    RelationshipManager.new(p4).make_relation(p1, 'Parent')
    RelationshipManager.relatives(p1).size.should == 3
  end
  
  context 'invalid relationships' do
    before do
      @p1 = Person.create(:first_name => 'alan', :last_name => 'jones')
      @p2 = Person.create(:first_name => 'ryan', :last_name => 'jones')
      @p3 = Person.create(:first_name => 'jim', :last_name => 'jones')
      RelationshipManager.new(@p1).make_relation(@p2, 'Parent')
      RelationshipManager.new(@p2).make_relation(@p3, 'Parent')
    end
    it 'should not create the same relationship twice' do
      expect {RelationshipManager.new(@p1, @p2, 'Parent')}.to raise_error
    end

    it 'should not create circular relationship' do
      expect {RelationshipManager.new(@p3).make_relation(@p1, 'Parent')}.to raise_error
    end

    it 'should not created invalid relation type' do
      expect {RelationshipManager.new(@p1).make_relation(@p2, 'dog')}.to raise_error
    end

    it 'should return parent' do
      expect(PersonManager.new(@p2).parents).to eq([@p1])
    end

    it 'should return children' do
      expect(PersonManager.new(@p1).children.first).to eq(@p2)
    end

    it 'should return head of family' do
      expect(PersonManager.new(@p2).furthest_ancestor).to eq([@p1])
    end
  end
end


