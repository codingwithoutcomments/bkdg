# == Schema Information
# Schema version: 20091207050051
#
# Table name: bands
#
#  id        :integer         not null, primary key
#  band_name :string(255)
#

class Band < ActiveRecord::Base
  
  has_many :bands_shows
  has_many :shows, :through => :played_games
  
  has_many :bandpictures
  
  def add_picture_to_band(picture)
    bandpictures << picture
  end
  
  def remove_picture_from_band(picture)
    bandpictures.delete(picture)
  end
  
  def has_pictures?
    if (bandpictures.count == 0)
      return false
    else 
      return true
    end
  end
  
  def get_XML_ready_string()
    band = band_name
    band = band.gsub('+', '%2B')
    band = band.gsub(' ', '+')
    band = band.gsub('&', '%26')
    band = band.gsub('$', '%24')
    band = band.gsub(',', '%2C')
    band = band.gsub('/', '%2F')
    band = band.gsub(':', '%3A')
    band = band.gsub(';', '%3B')
    band = band.gsub('=', '%3D')
    band = band.gsub('?', '%3F')
    band = band.gsub('@', '%40')
    
    return band
  end
  
end
