class AddOrderColumnToBandsShow < ActiveRecord::Migration
  def self.up
    add_column :bands_shows, :order, :integer
  end

  def self.down
    remove_column :bands_shows, :order
  end
end
