class AddUserIdColumnToCats < ActiveRecord::Migration
  def up
    add_column :cats, :user_id, :integer
    add_index :cats, :user_id
  end

  def down
    remove_column :cats, :user_id
  end
end
