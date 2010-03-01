class AddExtraLargeColumnToBandpictures < ActiveRecord::Migration
  def self.up
     add_column :bandpictures, :extralarge, :string
   end

   def self.down
     remove_column :bandpictures, :extralarge
   end
end
