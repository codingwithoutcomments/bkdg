class AddTicketLinkToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :ticket_link, :string
  end

  def self.down
    add_column :shows, :ticket_link, :string
  end
end
