class AddUserToTagging < ActiveRecord::Migration
  def up
    add_column :taggings, :user_id, :integer
  end

  def down
    drop_column :taggings, :user_id
  end
end
