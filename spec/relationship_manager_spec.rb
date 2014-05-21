require_relative '../lib/relationship_manager.rb'
require 'spec_helper'
describe RelationshipManager do
  before do
    @person = create :person
  end

  include FactoryGirl::Syntax::Methods
  it 'should make a relationship' do
    person1 = Person.create(:first_name => 'burt')
    person2 = Person.create(:first_name => 'matt')
    rel = RelationshipManager.new(person2, person1, 'Brother')
  end

  it 'should not make invalid relationship' do
    person2 = Person.new(:first_name => 'john')
    RelationshipManager.new(@person, person2, 'dog')
  end


  it 'should return relatives' do
    p1 = Person.create(:first_name => 'tony')
    p2 = Person.create(:first_name => 'burt')
    p3 = Person.create(:first_name => 'mike')
    p4 = Person.create(:first_name => 'joe')
    RelationshipManager.new(p1, p2, 'Brother')
    RelationshipManager.new(p1, p3, 'Sister')
    RelationshipManager.new(p1, p4, 'Sister')
    RelationshipManager.relatives(p1).size.should == 3
  end

  it 'should not create the same relationship twice' do
    p1 = Person.create(:first_name => 'alan')
    p2 = Person.create(:first_name => 'ryan')
    RelationshipManager.new(p1, p2, 'Brother')
    expect {RelationshipManager.new(p1, p2, 'Brother')}.to raise_error
  end

end


