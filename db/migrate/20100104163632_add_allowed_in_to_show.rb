class AddAllowedInToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :allowed_in, :string
  end

  def self.down
    remove_column :shows, :allowed_in
  end
end
