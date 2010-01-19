class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :headliner
      t.string :openers
      t.string :venue
      t.date :date
      t.time :time
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
