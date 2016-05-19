class CreatePostShares < ActiveRecord::Migration
  def change
    create_table :post_shares do |t|
      t.integer :friend_circle_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
    add_index :post_shares, [:friend_circle_id, :post_id], unique: true
  end
end
