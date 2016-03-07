require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_url
  end

  scenario "has a new user page" do
    expect(page).to have_content "Create User"
  end


  feature "signing up a user" do

    it "shows username on the homepage after signup" do

      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password

      click_on "Create User"
      expect(page).to have_content user.username
    end
  end
end

feature "logging in" do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_session_url

  end

  it "shows username on the homepage after login" do

    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password

    click_on "Sign In"
    expect(page).to have_content user.username
  end
end

feature "logging out" do
  let!(:user) { FactoryGirl.create(:user) }

  it "begins with logged out state" do
    visit "/"
    expect(page).to have_content "Sign In"
  end

  it "doesn't show username on the homepage after logout" do
    visit "/"

    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password

    click_on "Sign In"
    click_on "Sign Out"
    expect(page).not_to have_content user.username
  end

end
