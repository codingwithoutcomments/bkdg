class CreateBands < ActiveRecord::Migration
  def self.up
     create_table :bands do |t|
      t.string :band_name
    end
  end

  def self.down
    drop_table :bands
  end
end
