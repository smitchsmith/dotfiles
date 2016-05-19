require 'spec_helper'

describe Binary do
  it { should allow_mass_assignment_of :page_id }
  it { should allow_mass_assignment_of :file }
  it { should allow_mass_assignment_of :title }
  it { should validate_presence_of :title }
  it { should validate_presence_of :file }
  it { should belong_to :page }
end
