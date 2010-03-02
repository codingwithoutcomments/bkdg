class AddShowsPostedToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :shows_posted, :integer
   end

   def self.down
     remove_column :users, :shows_posted
   end
end
