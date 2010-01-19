class AddPhoneWebsiteToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :phone, :string
    add_column :venues, :website, :string
  end

  def self.down
    remove_column :venues, :phone
    remove_column :venues, :website
  end
end
