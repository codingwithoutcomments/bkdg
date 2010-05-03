class CreateFlagsTable < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.integer :reason
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :flags
  end
end
