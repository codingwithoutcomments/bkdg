class AddWebsiteLocationAgeToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :website, :string
     add_column :users, :location, :string
     add_column :users, :age, :string
   end

   def self.down
     remove_column :users, :website
     remove_column :users, :location
     remove_column :users, :age
   end
end
