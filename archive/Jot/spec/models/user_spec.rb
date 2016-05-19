require 'spec_helper'

describe User do

  before do
    @username = "test_user"
    @password =  123456
    @email = "test@test.com"
    @user = User.create!(username: @username, password: @password, email: @email)
  end

  it { should allow_mass_assignment_of :username }
  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :password }

  it { should validate_presence_of :username }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_digest }

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  it { should ensure_length_of(:password).is_at_least(6) }

  it { should allow_value("foo").for(:username) }
  it { should_not allow_value("foo@").for(:username) }

  it { should_not allow_value("foo").for(:email) }
  it { should allow_value("foo@").for(:email) }

  it { should have_many :pages }
  it { should have_many :comments }
  it { should have_many :favorites }
  it { should have_many :favorite_pages }
  it { should have_many :shares }
  it { should have_many :shared_to_pages }
  it { should have_many :saved_passwords }


  it "finds by username" do
    User.find_by_credentials(@username, @password).should eq @user
  end

  it "finds by email" do
    User.find_by_credentials(@email, @password).should eq @user
  end

  it "checks the password" do
    @user.is_password?(@password).should be_true
  end

  it "can reset password" do
    @user.reset_password_reset!
    @user.password_reset.should_not be_nil
  end

end
