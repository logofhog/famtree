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
    @person2 = FactoryGirl.create :person
    @relationship = Relationship.new(:person => @person,
                                     :relative => @person2,
                                     :rel_type => 'Child')
    sign_in @user
  end

  describe "GET 'new'" do
    subject {get 'new', {:id => @user.id } } 
    it "returns http success" do
      expect(subject).to render_template(:new)
    end
  end

  describe "POST 'create'" do
    subject {post 'create', {:relationship => @relationship.attributes } }
    it "redirects to root" do
      expect(subject).to redirect_to(root_path)
    end
  end

  describe "DELETE 'destroy'" do
    subject {delete 'destroy', {:id => '1'} }
    it "redirects to root" do
      @relationship.save
      expect(subject).to redirect_to(root_path)
    end
  end

end
