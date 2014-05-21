require 'spec_helper'

describe Relation do
  include FactoryGirl::Syntax::Methods
  it 'should create a relation' do
    relationship = create(:relation)
    relationship.rel_type.should == 'brother'
  end

end
