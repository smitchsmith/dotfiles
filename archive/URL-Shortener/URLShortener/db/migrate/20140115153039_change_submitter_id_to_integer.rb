class ChangeSubmitterIdToInteger < ActiveRecord::Migration
  def up
    change_column :shortened_urls, :submitter_id, :integer
  end

  def down
    change_column :shortened_urls, :submitter_id, :string
  end
end
