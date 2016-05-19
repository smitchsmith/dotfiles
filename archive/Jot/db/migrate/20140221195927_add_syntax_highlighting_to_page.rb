class AddSyntaxHighlightingToPage < ActiveRecord::Migration
  def change
    add_column :pages, :syntax_id, :integer, null: false, default: 1
    add_index :pages, :syntax_id
  end
end
