class AddTimeToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :showtime, :time
  end

  def self.down
    remove_column :shows, :showtime
  end
end
