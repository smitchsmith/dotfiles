class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :author

      t.timestamps
    end

    add_index(:polls, :author)
  end
end
