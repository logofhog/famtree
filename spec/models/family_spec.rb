require 'spec_helper'

describe Family do
  include FactoryGirl::Syntax::Methods

  it 'should make a family' do
    family = Family.create!(:family_name => 'smith', :new_password => 'hello', :description => 'this')
    #family = create :family
    family.family_name.should == 'smith'
  end

  it 'should add user to family' do
    family = Family.create!(:family_name => 'smith', :new_password => 'hello', :description => 'this')
    person =create :person
    person.update_attribute(:family_id, family.id)
    person.family.family_name.should == family.family_name
  end
  
  context 'family is created' do
    before do
      @family = Family.create!(:family_name => 'smith', :new_password => 'hello', :description => 'this')
    end

    it 'should make family password' do
      @family.family_name.should == 'smith'
    end

    it 'should return family with name/password' do
      family_to_get = Family.authenticate(@family.family_name, 'hello')
      family_to_get.family_name.should == 'smith'
    end

    it 'should not return family with invalid password' do
      family_to_get = Family.authenticate(@family.family_name, 'dogs')
      family_to_get.should be_nil
    end

  end
  
end
