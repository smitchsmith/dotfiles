class CreateBinaries < ActiveRecord::Migration
  def change
    create_table :binaries do |t|
      t.integer :page_id, null: false

      t.attachment :file

      t.timestamps
    end
  end
end
