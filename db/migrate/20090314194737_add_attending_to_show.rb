class AddAttendingToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :attending, :integer, :default => 0
  end

  def self.down
    remove_column :shows, :attending
  end
end
