require "spec_helper"

feature "creating a goal" do

  before :each do gen_and_sign_in("ADN") end

  it "has a link to create a new goal" do
    expect(page).to have_content "New Goal"
  end

  it "has a form to create a new goal" do
    click_link "New Goal"
    expect(page).to have_content "New Goal"
    expect(page).to have_button "Create Goal"
  end

  it "actually creates a goal" do
    create_goal("Learn to weave")
    expect(page).to have_content "Learn to weave"
    expect(page).to have_content "ADN's goals"
  end

end


feature "scoping goals" do

  before :each do
    gen_and_sign_in("ADN")
    create_goal("Learn Rails")
    create_goal("Get a job", false)
    sign_out
    gen_and_sign_in("MTCH")
    visit user_url(User.find_by_username("ADN"))
  end

  it "shows public goals to other users" do
    expect(page).to have_content("Learn Rails")
  end

  it "doesn't show private goals to other users" do
    expect(page).not_to have_content("Get a job")
  end

end