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
  
  def to_param
    "#{id}-#{city.downcase.parameterize}-#{state.downcase.parameterize}"
  end
  
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
  
  def get_state_parameterized()

    tempState = state
    tempState = tempState.gsub('+', '%2B')
    tempState = tempState.gsub(' ', '+')
    tempState = tempState.gsub('&', '%26')
    tempState = tempState.gsub('$', '%24')
    tempState = tempState.gsub(',', '%2C')
    tempState = tempState.gsub('/', '%2F')
    tempState = tempState.gsub(':', '%3A')
    tempState = tempState.gsub(';', '%3B')
    tempState = tempState.gsub('=', '%3D')
    tempState = tempState.gsub('?', '%3F')
    tempState = tempState.gsub('@', '%40')
    
    return tempState
  end
  
end
