class CreateFriendCircleMemberships < ActiveRecord::Migration
  def change
    create_table :friend_circle_memberships do |t|
      t.integer :friend_circle_id, null: false
      t.integer :friend_id, null: false

      t.timestamps
    end
    add_index :friend_circle_memberships, [:friend_circle_id, :friend_id], unique: true, name: "circle-friend-combo"
  end
end
