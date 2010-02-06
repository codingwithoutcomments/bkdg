class ReAddTimestampsToBandShows < ActiveRecord::Migration
  def self.up
    add_timestamps :bands_shows
  end

  def self.down
    add_timestamps :bands_shows
  end
end
