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
  
  def get_city_parameterized()

    tempCity = city
    tempCity = tempCity.gsub('+', '%2B')
    tempCity = tempCity.gsub(' ', '+')
    tempCity = tempCity.gsub('&', '%26')
    tempCity = tempCity.gsub('$', '%24')
    tempCity = tempCity.gsub(',', '%2C')
    tempCity = tempCity.gsub('/', '%2F')
    tempCity = tempCity.gsub(':', '%3A')
    tempCity = tempCity.gsub(';', '%3B')
    tempCity = tempCity.gsub('=', '%3D')
    tempCity = tempCity.gsub('?', '%3F')
    tempCity = tempCity.gsub('@', '%40')
    
    return tempCity
  end
  
end
