require 'spec_helper'
require_relative '../../lib/relationship_manager.rb'

describe RelationshipsController do

  include Devise::TestHelpers
  before do
    user = double('user')
    request.env['warden'].stub :authenticate! => user
    controller.stub :current_user => user
    @person = FactoryGirl.create :person
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
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
