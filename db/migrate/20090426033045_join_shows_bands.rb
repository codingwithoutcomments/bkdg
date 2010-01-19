class JoinShowsBands < ActiveRecord::Migration
  def self.up
    create_table :bands_shows, :id =>false do |t|
      t.integer :show_id
      t.integer :band_id
    end
    
    add_index :bands_shows, [:show_id, :band_id], :unique => true
    add_index :bands_shows, :band_id, :unique =>false
  end

  def self.down
    drop_table :bands_shows
  end
  
end
