require 'spec_helper'

describe Sub do

  context "when creating a sub" do
    it "fails if missing name or moderator" do
      FactoryGirl.build(:sub, name: nil, user_id: 1).should_not be_valid
      FactoryGirl.build(:sub, name: "Reddit", user_id: nil).should_not be_valid
    end

    it "belongs to a moderator" do
      bob = FactoryGirl.create(:user, username: "bob", password: "123")
      sub = FactoryGirl.build(:sub, name: "WTF", user_id: bob.id)
      expect(sub.moderator).to eq(bob)
    end
  end

  it "has many links" do
    sub = FactoryGirl.create(:sub)
    link = FactoryGirl.create(:link)

    link.subs << sub

    sub.links.first.should be_instance_of(Link)
  end

end
