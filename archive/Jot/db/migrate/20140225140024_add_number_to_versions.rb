class AddNumberToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :number, :integer, null: false, default: 1
  end
end
