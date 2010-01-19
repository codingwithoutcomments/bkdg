class ChangeNameForPicturelocation < ActiveRecord::Migration
  def self.up
    rename_column :bandpictures, :picture_location, :original
  end

  def self.down
    rename_column :bandpictures, :original, :picture_location
  end
end
