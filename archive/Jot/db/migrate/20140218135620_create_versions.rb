class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :page_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
