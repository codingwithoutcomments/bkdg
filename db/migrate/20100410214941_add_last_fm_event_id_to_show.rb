class AddLastFmEventIdToShow < ActiveRecord::Migration
  def self.up
     add_column :shows, :last_fm_event_id, :string
   end

   def self.down
     remove_column :shows, :last_fm_event_id
   end
end
