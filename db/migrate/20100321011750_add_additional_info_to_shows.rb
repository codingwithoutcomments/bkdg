class AddAdditionalInfoToShows < ActiveRecord::Migration
  def self.up
     add_column :shows, :additional_info, :text
   end

   def self.down
     remove_column :shows, :additional_info
   end
end
