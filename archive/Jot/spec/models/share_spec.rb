require 'spec_helper'

describe Share do
  it { should allow_mass_assignment_of :page_id }
  it { should allow_mass_assignment_of :sharer_id }
  it { should allow_mass_assignment_of :sharee_id }

  it { should validate_presence_of :page_id }
  it { should validate_presence_of :sharer_id }
  it { should validate_presence_of :sharee_id }

  it { should belong_to :page }
  it { should belong_to :sharer }
  it { should belong_to :sharee }

end
