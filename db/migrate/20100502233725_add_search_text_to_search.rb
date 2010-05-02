class AddSearchTextToSearch < ActiveRecord::Migration
  def self.up
     add_column :searches, :search_text, :string
  end

  def self.down
    remove_column :searches, :search_text
  end
end
