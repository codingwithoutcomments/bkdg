class CreateBandpictures < ActiveRecord::Migration
  def self.up
    create_table :bandpictures do |t|
      t.string :picture_location
      t.timestamps
    end
  end

  def self.down
    drop_table :bandpictures
  end
end
