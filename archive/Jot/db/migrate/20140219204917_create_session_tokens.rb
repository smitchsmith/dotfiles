class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.integer :user_id
      t.string :session_token, unique: true

      t.timestamps
    end

    add_index :session_tokens, :user_id
  end
end
