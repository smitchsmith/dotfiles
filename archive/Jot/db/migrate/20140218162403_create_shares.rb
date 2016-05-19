class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :page_id, null: false
      t.integer :sharer_id, null: false
      t.integer :sharee_id, null: false

      t.timestamps
    end

    add_index :shares, :page_id
    add_index :shares, :sharer_id
    add_index :shares, :sharee_id
    add_index :shares, [:page_id, :sharee_id], unique: true
  end
end
