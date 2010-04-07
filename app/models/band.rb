# == Schema Information
# Schema version: 20091207050051
#
# Table name: bands
#
#  id        :integer         not null, primary key
#  band_name :string(255)
#

require 'open-uri'

class Band < ActiveRecord::Base
  
  has_many :bands_shows
  has_many :shows, :through => :bands_shows
  
  has_many :bandpictures
  has_many :bandsongs
  
  def to_param
     "#{id}-#{band_name.downcase.parameterize}"
   end
  
  def add_picture_to_band(picture)
    bandpictures << picture
  end
  
  def remove_picture_from_band(picture)
    bandpictures.delete(picture)
  end
  
  def add_song_to_band(song)
    bandsongs << song
  end
  
  def remove_song_from_band(song)
    bandsongs.delete(song)
  end
  
  def get_songs
    if(!has_songs?) then
      headliner_sans_spaces = get_grooveshark_ready_string()
      get_picture_string = "http://tinysong.com/s/" + headliner_sans_spaces + "&limit=15"
      responseString = open(get_picture_string)
      responseString.each_line { |line|
      
        @songArray = line[0..-3].split(';')
        if(@songArray.length == 8) then
          song = Bandsong.new
          song.song_id = @songArray.at(1).strip!
          song.save
          add_song_to_band(song)
        end
      }
    end
      
      rescue OpenURI::HTTPError
        logger.error("Unable to get songs for #{band_name} from grooveshark")

  end
  
  def get_song_string
    songString = ""
    if(bandpictures.length == 0) then
      return ""
    else
      bandsongs.each do |song|
        songString = songString + song.song_id + ","
      end
      
      return songString
    end
    
  end
  
  def has_songs?
    if(bandsongs.length == 0) then 
      return false
    else   
      return true
    end
  end
  
  def has_pictures?
    if (bandpictures.count == 0)
      return false
    else 
      return true
    end
  end
  
  def get_grooveshark_ready_string()
    band = band_name
    band = band.gsub('+', '%2B')
    band = band.gsub(' ', '+')
    band = band.gsub('&', '%26')
    band = band.gsub('$', '%24')
    band = band.gsub(',', '%2C')
    band = band.gsub('/', '+')
    band = band.gsub(':', '%3A')
    band = band.gsub(';', '%3B')
    band = band.gsub('=', '%3D')
    band = band.gsub('?', '%3F')
    band = band.gsub('@', '%40')
    
    return band
    
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
