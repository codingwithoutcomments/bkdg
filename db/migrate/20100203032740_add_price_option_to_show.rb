class AddPriceOptionToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :price_option, :string
  end

  def self.down
    remove_column :shows, :price_option
  end
end
