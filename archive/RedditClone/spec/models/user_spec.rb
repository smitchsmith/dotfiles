require 'spec_helper'

describe User do

  context "when creating a user" do
    it "validates the presence of username" do
      FactoryGirl.build(:user, username: nil).should_not be_valid
    end

    it "validates the uniqueness of username" do
      FactoryGirl.create(:user).should be_valid
      FactoryGirl.build(:user).should_not be_valid
    end
  end

  it "finds a user by credentials" do
    user = FactoryGirl.create(:user)
    User.find_by_credentials("bob", "123").should eq(user)
  end

  it "resets token when reset_token! is called" do
    user = FactoryGirl.create(:user)
    token = user.session_token
    new_token = user.reset_token!

    token.should_not eq(new_token)
  end
  # it "doesn't store the password" do
  #   FactoryGirl.create(:user, username: "bob", password: "123123")
  #   User.find_by_username("bob").password.should be_nil
  # end

end
