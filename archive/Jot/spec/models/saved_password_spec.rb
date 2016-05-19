require 'spec_helper'

describe SavedPassword do
  it { should allow_mass_assignment_of :digest }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :page_id }
  it { should validate_presence_of :digest }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :page_id }

  it do
    SavedPassword.create!(user_id: 1, page_id: 1, digest: "sdfsadfsag")
    should validate_uniqueness_of(:user_id).scoped_to(:page_id)
  end

  it { should belong_to :page }
  it { should belong_to :user }
end
