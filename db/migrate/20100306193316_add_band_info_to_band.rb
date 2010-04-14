class AddBandInfoToBand < ActiveRecord::Migration
  def self.up
      add_column :bands, :info, :text
    end

    def self.down
      remove_column :bands, :info
    end
end
