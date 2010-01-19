class RemoveVenueColumnFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :venue
  end

  def self.down
    add_column :shows, :venue, :string
  end
end
