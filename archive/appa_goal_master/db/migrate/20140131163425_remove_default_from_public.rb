class RemoveDefaultFromPublic < ActiveRecord::Migration
  def change
    change_column_default :goals, :public, nil
  end
end
