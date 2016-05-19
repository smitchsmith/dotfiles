class CreateSavedPasswords < ActiveRecord::Migration
  def change
    create_table :saved_passwords do |t|
      t.integer :page_id, null: false
      t.integer :user_id, null: false
      t.string :digest, null: false

      t.timestamps
    end
    add_index :saved_passwords, :page_id
    add_index :saved_passwords, :user_id
    add_index :saved_passwords, [:user_id, :page_id], unique: true
  end
end
