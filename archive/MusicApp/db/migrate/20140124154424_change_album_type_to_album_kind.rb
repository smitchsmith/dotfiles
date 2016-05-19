class ChangeAlbumTypeToAlbumKind < ActiveRecord::Migration
  def change
    rename_column :albums, :recorded, :kind
  end
end
