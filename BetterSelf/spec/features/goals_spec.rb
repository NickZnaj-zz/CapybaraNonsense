require 'spec_helper'
require 'rails_helper'

feature "user has goals" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:goal) { FactoryGirl.create(:goal) }

  before(:each) do
    visit new_session_url

    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password

    click_on "Sign In"
  end

  feature "User adds goals from show page" do

    scenario "adding private goal is only visible on user's page" do
      goal = FactoryGirl.create(:goal, share_goal: false)

      fill_in "Goal Description", :with => goal.description
      choose "Private?"
      click_on "Submit Goal"

      expect(page).to have_content goal.description
      visit users_url
      expect(page).not_to have_content goal.description

    end


    scenario "adding public goal is visible on user index" do
      fill_in "Goal Description", :with => goal.description
      choose "Public?"
      click_on "Submit Goal"

      expect(page).to have_content goal.description
      visit users_url
      expect(page).to have_content goal.description

    end

  end

end
