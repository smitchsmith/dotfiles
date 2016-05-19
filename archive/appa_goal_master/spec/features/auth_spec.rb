require 'spec_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      sign_up_user
      expect(page).to have_content "MyName"
    end
  end
end

feature "logging in" do

  before { generate_user("MyName") }

  it "shows username on the homepage after login" do
    sign_up_user
    expect(page).to have_content "MyName"
  end
end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).not_to have_content "Sign Out"
  end

  it "doesn't show username on the homepage after logout" do
    generate_user("AnotherName")
    sign_in_user("AnotherName")
    expect(page).to have_content "AnotherName"
    click_button "Sign Out"
    expect(page).not_to have_content "AnotherName"
  end

end