class AddAdvancepriceToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :advanceprice, :decimal,
      :precision => 8, :scale => 2
  end

  def self.down
    remove_column :shows, :advanceprice
  end
end
