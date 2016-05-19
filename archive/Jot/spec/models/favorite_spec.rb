require 'spec_helper'

describe Favorite do
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :page_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :page_id }
  it { should belong_to :user }
  it { should belong_to :page }
  it do
    page = Page.new({title: "Test3", is_public: false, password: ""})
    page.url_fragment = "foo"
    page.save!

    user = User.create!({email: "foo@foo.com" , username: "foo", password: "123456"})

    Favorite.create!(user_id: user.id, page_id: page.id)

    should validate_uniqueness_of(:user_id).scoped_to(:page_id)
  end
end
