class ChangeSessionTokensOnSessionTokens < ActiveRecord::Migration
  def change
    rename_column :session_tokens, :session_token, :token
  end
end
