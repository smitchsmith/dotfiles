class CreateSyntaxes < ActiveRecord::Migration
  def change
    create_table :syntaxes do |t|
      t.string :highlighting, null: false
      t.timestamps
    end
  end
end
