class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :user_comment
      t.timestamps
    end
  end

  def self.down
    drop_table :comment
  end
end
