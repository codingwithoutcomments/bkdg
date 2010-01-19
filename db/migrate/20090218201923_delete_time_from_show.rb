class DeleteTimeFromShow < ActiveRecord::Migration
  def self.up
    remove_column :shows, :time
  end

  def self.down
    add_column :shows, :time, :time
  end
end
