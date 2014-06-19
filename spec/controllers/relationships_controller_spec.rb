require 'spec_helper'
require_relative '../../lib/relationship_manager.rb'

describe RelationshipsController do

  include Devise::TestHelpers
  before do
    @person = FactoryGirl.create :person
    @family = FactoryGirl.create :family
    @user = FactoryGirl.create(:user, :family_id => @family.id)
    @family = FactoryGirl.create :family
    @person.family_id = @family.id
    sign_in @user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', {:id => @user.id }
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      person2 = FactoryGirl.create :person
      relationship = Relationship.new(:person => @person,
                                      :relative => person2,
                                      :rel_type => 'Child')
      post 'create', {:relationship => relationship.attributes } 
      response.should redirect_to root_path
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', {:id => '1'}
      response.should be_success
    end
  end

end
