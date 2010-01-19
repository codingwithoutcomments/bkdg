class AddLocationIDcolumnToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :location_id, :integer
  end

  def self.down
    remove_column :venues, :location_id
  end
end
