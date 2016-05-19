class RemoveNullConstraintFromCommentsUserId < ActiveRecord::Migration
  def change
    change_column :comments, :owner_id, :integer, null: true
  end
end
