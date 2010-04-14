class AddBandsongs < ActiveRecord::Migration
  def self.up
    create_table :bandsongs do |t|
      t.integer :band_id
      t.string :song_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bandsongs
  end
end
