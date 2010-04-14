class AddShowsLastGrabbedToBand < ActiveRecord::Migration
  def self.up
    add_column :bands, :shows_last_grabbed, :date
  end

  def self.down
    remove_column :bands, :shows_last_grabbed
  end
end
