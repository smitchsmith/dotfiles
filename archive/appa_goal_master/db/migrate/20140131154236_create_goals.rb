class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :description
      t.boolean :public, default: true
      t.boolean :completed, default: false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
