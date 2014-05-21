require 'spec_helper'

describe Family do
  include FactoryGirl::Syntax::Methods

  it 'should make a family' do
    family = create(:family)
    family.family_name.should == 'smiths'
  end

  it 'should add user to family' do
    family = create :family
    person =create :person
    person.update_attribute(:family_id, family.id)
    person.family.family_name.should == family.family_name
  end
end
