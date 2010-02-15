class AddEditedByToShow < ActiveRecord::Migration
  def self.up
     add_column :shows, :edited_by, :integer
   end

   def self.down
     remove_column :shows, :edited_by
   end
end
