require 'spec_helper'

describe "new person process", :type => :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  before :each do
    user = User.create(:email => 'example@example.com', :password => 'password')
    family = FactoryGirl.create :family
    user.update_attribute(:family, family)
    login_as(user)
  end
  
  it "creates a new person with valid data" do
    visit new_person_path
    within 'form' do
      fill_in 'person_first_name', :with => 'Ted'
      fill_in 'person_last_name', :with => 'Smith'
    end
    click_button 'Save New Person'
    expect(page).to have_content 'Created new person'
  end

  it "does not create person with invalid data" do
    visit new_person_path
    within 'form' do
      fill_in 'person_first_name', :with => 'ted'
    end
    click_button 'Save New Person'
    expect(page).to have_content "Last name can't be blank"
  end

  it "does not allow invalid email address" do
    visit new_person_path
    within 'form' do
      fill_in 'person_first_name', :with => 'ted'
      fill_in 'person_last_name', :with => 'Smith'
      fill_in 'person_email', :with => 'bademail'
    end
    click_button 'Save New Person'
    expect(page).to have_content "Email is invalid"
  end

end


