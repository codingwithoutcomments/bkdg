class AddBandidToPictures < ActiveRecord::Migration
  def self.up
    add_column :bandpictures, :band_id, :integer
  end

  def self.down
    drop_column :bandpictures, :band_id
  end
end
