class AddShowIDcolumnToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :show_id, :integer
  end

  def self.down
    remove_column :comments, :show_id
  end
end
