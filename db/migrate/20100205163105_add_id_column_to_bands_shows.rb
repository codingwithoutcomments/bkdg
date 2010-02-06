class AddIdColumnToBandsShows < ActiveRecord::Migration
  def self.up
    add_column :bands_shows, :id, :integer
  end

  def self.down
    remove_column :bands_shows, :id
  end
end
