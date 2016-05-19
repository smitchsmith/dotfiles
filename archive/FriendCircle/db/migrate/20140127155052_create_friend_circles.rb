class CreateFriendCircles < ActiveRecord::Migration
  def change
    create_table :friend_circles do |t|
      t.integer :user_id, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :friend_circles, :user_id
  end
end
