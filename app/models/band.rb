# == Schema Information
# Schema version: 20091207050051
#
# Table name: bands
#
#  id        :integer         not null, primary key
#  band_name :string(255)
#

class Band < ActiveRecord::Base
  has_and_belongs_to_many :shows
  has_many :bandpictures
  
  def add_picture_to_band(picture)
    bandpictures << picture
  end
  
  def remove_picture_from_band(picture)
    bandpictures.delete(picture)
  end
  
  def has_pictures?
     RAILS_DEFAULT_LOGGER.error(bandpictures.count.to_s)
    if (bandpictures.count == 0)
      return false
    else 
      return true
    end
  end
  
end
