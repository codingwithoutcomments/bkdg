class RemoveHeadlinerOpenersFromShow < ActiveRecord::Migration
  def self.up
    remove_column :shows, :headliner
    remove_column :shows, :openers
  end

  def self.down    
    add_column :shows, :headliner
    add_column :shows, :openers
  end
  
end
