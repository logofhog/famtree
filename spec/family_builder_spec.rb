require 'spec_helper'
require_relative '../lib/family_builder.rb'
require_relative '../lib/relationship_manager.rb'

describe FamilyBuilder do

  context 'have parents' do
    before do
      @family = FactoryGirl.create :family
      @head_of_family = Person.create(:first_name => 'suzy',
                                :last_name => 'suze',
                                :family_id => @family.id)
      @person = FactoryGirl.create(:person, :family_id => @family.id)
      @person1 = FactoryGirl.create(:person, :family_id => @family.id)
      @person2 = FactoryGirl.create(:person, :family_id => @family.id)
      @person3 = FactoryGirl.create(:person, :family_id => @family.id)
      @person4 = FactoryGirl.create(:person, :family_id => @family.id)
      @person5 = FactoryGirl.create(:person, :family_id => @family.id)
      @person8 = FactoryGirl.create(:person, :family_id => @family.id)
      RelationshipManager.new(@head_of_family, @person1, 'Parent')
      RelationshipManager.new(@head_of_family, @person5, 'Parent')
      RelationshipManager.new(@person1, @person2, 'Parent')
      RelationshipManager.new(@person2, @person3, 'Parent')
      RelationshipManager.new(@person3, @person4, 'Parent')
    end


    it 'should add user to family' do
      expect(@person.family_id).to eq(@family.id)
    end

    it 'should create set of in order' do
      @person6 = FactoryGirl.create(:person, :family_id => @family.id).save
      @person7 = FactoryGirl.create(:person, :family_id => @family.id).save
      expect(FamilyBuilder.new(@family).tree.first[:person]).to eq(@head_of_family)
    end

    it 'should make each person have person/generation set' do
      expect(FamilyBuilder.new(@family).tree.first).to have_key(:person)
      expect(FamilyBuilder.new(@family).tree.first).to have_key(:generation)
    end

    it 'should have every person in family' do
      expect(FamilyBuilder.new(@family).tree).to have(8).items
    end
    

  end
end


