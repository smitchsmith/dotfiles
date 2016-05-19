require 'spec_helper'

feature "admin users" do

  before do
    gen_and_sign_in("ADN")
    create_goal("Get a job", false)
    sign_out
    gen_and_sign_in("admin")
    user = User.find_by_username("admin")
    user.admin = true
    user.save!
    visit users_url
  end

  it "can see any goal" do
    expect(page).to have_content("Get a job")
  end

  it "can delete any goal" do
    expect(page).to have_button("Delete ADN's Goal")
    click_button "Delete ADN's Goal"
    expect(page).not_to have_content("Get a job")
  end

  it "deletes any user" do
    visit users_url
    expect(page).to have_button("Delete ADN")
    click_button "Delete ADN"
    expect(page).not_to have_content("ADN")
  end

end