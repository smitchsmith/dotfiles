require 'spec_helper'

describe SessionToken do
  it { should allow_mass_assignment_of :token }
  it { should allow_mass_assignment_of :user_id }

  it { should validate_presence_of :user_id }

  it { should belong_to :user }

  it "should ensure a session token" do
    session_token = SessionToken.create!({user_id: 1})
    session_token.token.should_not be_nil
  end

end