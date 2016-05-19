class AddTitleToSyntax < ActiveRecord::Migration
  def change
    add_column :syntaxes, :title, :string, null: false
  end
end
