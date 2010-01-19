class AddVenueIdColunnToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :venue_id, :integer
  end

  def self.down
    remove_column :shows, :venue_id, :integer
  end
end
