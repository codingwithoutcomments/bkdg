# == Schema Information
# Schema version: 20091207050051
#
# Table name: locations
#
#  id    :integer         not null, primary key
#  city  :string(255)
#  state :string(255)
#

class Location < ActiveRecord::Base
  has_many :shows
  has_many :venues
  
  def add_show_to_location(show)
    shows << show
  end
  
  def remove_show_from_location(show)
    shows.delete(show)
  end
  
  def add_venue_to_location(venue)
    venues << venue
  end
  
  def remove_venue_from_location(venue)
    venues.remove(venue)
  end
  
end
