class AddShowIdToFlags < ActiveRecord::Migration
  def self.up
     add_column :flags, :show_id, :integer
  end

  def self.down
    remove_column :flags, :show_id
  end
end
