class AddColumnsToBandpictures < ActiveRecord::Migration
  def self.up
    add_column :bandpictures, :large, :string
    add_column :bandpictures, :largesquare, :string
    add_column :bandpictures, :medium, :string
    add_column :bandpictures, :small, :string
  end

  def self.down
    remove_column :bandpictures, :large
    remove_column :bandpictures, :largesquare
    remove_column :bandpictures, :medium
    remove_column :bandpictures, :small
  end
end
