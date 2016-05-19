class ChangeTrackTypeToTrackKind < ActiveRecord::Migration
  def change
    rename_column :tracks, :type, :kind
  end
end
