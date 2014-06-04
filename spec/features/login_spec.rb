require 'spec_helper'

describe "sign in process", :type => :feature do
  before :each do
    User.create(:email => 'example@example.com', :password => 'password')
  end

  it 'signs in successfully' do
    visit 'users/sign_in'
    within ('body') do
      fill_in 'user_email', :with => 'example@example.com'
      fill_in 'user_password', :with => 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
  end
end


