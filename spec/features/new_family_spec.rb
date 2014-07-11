require 'spec_helper'

describe "new family process", :type => :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  before :each do
    user = User.create(:email => 'example@example.com', :password => 'password')
    login_as(user)
  end

  it "creates a new family" do
    visit new_family_path
    within 'form' do
      fill_in 'family_family_name', :with => 'Smith'
      fill_in 'family_description', :with => 'the Smith family'
      fill_in 'family_password', :with => 'password'
      fill_in 'family_password_comfirmation', :with => 'password'
    end
    click_button 'New Family'
    expect(page).to have_content 'Created new family'
  end
end



