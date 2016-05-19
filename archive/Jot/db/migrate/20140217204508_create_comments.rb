class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :owner_id, null: false
      t.integer :page_id, null: false

      t.string :body, null: false

      t.timestamps
    end

    add_index :comments, :owner_id
    add_index :comments, :page_id
  end
end
