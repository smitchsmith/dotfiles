class RemoveBodyFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :body
  end
end
