class AddShowtimeToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :time, :string
  end

  def self.down
    remove_column :shows, :time
  end
end
