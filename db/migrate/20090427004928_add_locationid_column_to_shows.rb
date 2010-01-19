class AddLocationidColumnToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :location_id, :integer
  end

  def self.down
    remove_column :shows, :location_id, :integer
  end
end
