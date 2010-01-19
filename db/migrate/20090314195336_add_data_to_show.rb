class AddDataToShow < ActiveRecord::Migration
  def self.up
  
  end

  def self.down
    Show.delete_all
  end
end
