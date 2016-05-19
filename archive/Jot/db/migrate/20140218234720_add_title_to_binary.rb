class AddTitleToBinary < ActiveRecord::Migration
  def change
    add_column :binaries, :title, :string
  end
end
