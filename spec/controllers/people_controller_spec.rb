require 'spec_helper'

describe PeopleController do
  include Devise::TestHelpers


  before do
    @user = FactoryGirl.create :user
    sign_in @user
    @person = FactoryGirl.create :person
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', {:id => @person.id}
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      new_person = FactoryGirl.create :person
      post 'create', {:person => new_person.attributes}
      response.should redirect_to('/')
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', {:id => @person.id}
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "returns http success" do
      post 'update', {:id => @person.id, :person => @person.attributes}
      response.should redirect_to('/')
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', {:id => '1'}
      response.should be_success
    end
  end

end
