# == Schema Information
# Schema version: 20091207050051
#
# Table name: venues
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  address     :string(255)
#  location_id :integer
#  phone       :string(255)
#  website     :string(255)
#

class Venue < ActiveRecord::Base
  has_many :shows
  belongs_to :location
  
  def add_show_to_venue(show)
    shows << show
  end
  
  def remove_show_from_venue(show)
    shows.delete(show)
  end
  
end
