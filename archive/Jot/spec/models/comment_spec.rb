require 'spec_helper'

describe Comment do
  it { should allow_mass_assignment_of :body }
  it { should allow_mass_assignment_of :owner_id }
  it { should allow_mass_assignment_of :page_id }
  it { should validate_presence_of :body }
  it { should validate_presence_of :page_id }
  it { should belong_to :page }
  it { should belong_to :owner }
end
