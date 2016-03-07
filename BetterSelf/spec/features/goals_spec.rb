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

    feature "User's private goals are hidden from others" do

      scenario "User can only create goals on their own page" do

        click_on "Sign Out"
        other_user = FactoryGirl.build(:user, username: "Fred")
        visit new_user_url

        fill_in 'Username', :with => other_user.username
        fill_in 'Password', :with => other_user.password

        click_on "Sign Up"

        visit user_url(user)
        expect(page).to_not have_content "Submit Goal"

      end

    end

    feature "Goals can be marked as completed" do
      goal = FactoryGirl.create(:goal, share_goal: false, user_id: 2)
      before(:each) do
        other_user = FactoryGirl.build(:user, username: "Fred")
        visit new_user_url

        fill_in 'Username', :with => other_user.username
        fill_in 'Password', :with => other_user.password
        save_and_open_page
        click_on "Sign Up"

        fill_in 'Description', :with => goal.description
        choose "Public?"
        click_on "Submit Goal"
      end

      scenario "User can mark own goals as completed" do
        choose "Completed?"
        expect(page).to have_content "Complete Goal"

      end

    end


  end

end
