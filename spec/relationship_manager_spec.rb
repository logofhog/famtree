require_relative '../lib/relationship_manager.rb'
require 'spec_helper'
describe RelationshipManager do
  before do
    @person = create :person
  end

  include FactoryGirl::Syntax::Methods
  it 'should make a relationship' do
    person1 = Person.create(:first_name => 'burt')
    rel = RelationshipManager.new(@person, person1, 'Brother')
  end

  it 'should not make invalid relationship' do
    person2 = Person.new(:first_name => 'john')
    RelationshipManager.new(@person, person2, 'dog')
  end


  it 'should return relatives' do
    p1 = create :person
    p2 = create :person
    p3 = create :person
    p4 = create :person
    RelationshipManager.new(p1, p2, 'Brother')
    RelationshipManager.new(p1, p3, 'Sister')
    RelationshipManager.new(p1, p4, 'Sister')
    RelationshipManager.relatives(p1).size.should == 3
  end

end


