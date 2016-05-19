require 'spec_helper'

describe Page do

  before do
    @page = Page.new(title: "Test Title",
                          password: "")
    @page.url_fragment = "foo"
    @page.save
  end

  it { should allow_mass_assignment_of :title }
  it { should allow_mass_assignment_of :password }
  it { should allow_mass_assignment_of :is_public }

  it { should validate_presence_of :title }
  it { should validate_presence_of :url_fragment }
  # it { should ensure_inclusion_of(:is_public).in_array([true, false]) }
  # shoulda matchers don't support this ^
  it { should validate_uniqueness_of :url_fragment }
  it { should ensure_length_of(:url_fragment).is_at_least(2) }
  it { should belong_to :owner }
  it { should have_many :comments }
  it { should have_many :versions }
  it { should have_many :favorites }
  it { should have_many :favorited_by_users }
  it { should have_many :shares }
  it { should have_many :shared_users }
  it { should have_many :binaries }
  it { should have_many :saved_passwords }

  it "doesn't set a password when given an empty string" do
    @page.password_digest.should be_nil
  end

  it "checks the password" do
    password =  123456.to_s
    page = Page.new(title: "Test Title 2",
                         password: password)
    page.url_fragment = "foo"
    page.save

    page.is_password?(password).should be_true
  end

end
