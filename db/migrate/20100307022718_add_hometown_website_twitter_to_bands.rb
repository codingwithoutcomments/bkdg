class AddHometownWebsiteTwitterToBands < ActiveRecord::Migration
  def self.up
     add_column :bands, :website, :string
     add_column :bands, :hometown, :string
     add_column :bands, :twitter, :string
   end

   def self.down
     remove_column :bands, :website
     remove_column :bands, :location
     remove_column :bands, :age
   end
end
