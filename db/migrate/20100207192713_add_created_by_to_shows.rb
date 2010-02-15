class AddCreatedByToShows < ActiveRecord::Migration
  def self.up
     add_column :shows, :posted_by, :integer
   end

   def self.down
     remove_column :shows, :posted_by
   end
end
