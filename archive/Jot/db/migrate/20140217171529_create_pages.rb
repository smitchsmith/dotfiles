class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :url_fragment, null: false
      t.boolean :is_public, null: false, default: true

      t.string :password_digest
      t.integer :owner_id

      t.timestamps
    end

    add_index :pages, :owner_id
    add_index :pages, :url_fragment, unique: true
  end
end