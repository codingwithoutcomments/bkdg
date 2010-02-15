class ChangePriceColumnToACertainPrecision < ActiveRecord::Migration
  def self.up
    change_column :shows, :price, :decimal,
      :precision => 8, :scale => 2
  end

  def self.down
    change_column :shows, :price, :decimal
  end
end
