# == Schema Information
# Schema version: 20091207050051
#
# Table name: bands
#
#  id        :integer         not null, primary key
#  band_name :string(255)
#

require 'open-uri'
require 'timeout'

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
    
    responseString = ""
    
    if(!has_songs?) then

      get_picture_string = "http://tinysong.com/s/" + CGI::escape(band_name) + "&limit=15"
      
      timeout(5) do
        responseString = open(get_picture_string)
      end
      
      responseString.each_line { |line|
      
        @songArray = line[0..-3].split(';')
        if(@songArray.length == 8) then
          song = Bandsong.new
          song.song_id = @songArray.at(1).strip!
          if(@songArray.at(4).strip!.upcase == band_name) then
            song.save
            add_song_to_band(song)
          end
        end
      }
    end
    
    rescue Timeout::Error
      logger.error("Unable to get songs for #{band_name} from grooveshark")
      
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
    band = band.gsub('&AMP;', '%26')
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
  
  def get_upcoming_shows_from_last_fm
    
    if(shows_last_grabbed == nil || shows_last_grabbed != Date.current)
    
      last_fm_event_string = "http://ws.audioscrobbler.com/2.0/?method=artist.getEvents&artist=" + CGI::escape(band_name) + "&api_key=7a8a93a66b33946440ad048191c80609"
      xml_retrieved = open(last_fm_event_string)
      doc = Hpricot.XML(xml_retrieved)
      (doc/:event).each do |event|
            event_id = event.at("id").inner_html
            event_country = event.at("country").html
            #if event doesn't already exist create
            if(Show.last_fm_event_id_equals(event_id).first == nil && (event_country == "United States" || event_country == "Canada")) then
            
              #get or create the event location
              eventLocationArray = event.at("city").inner_html.split(",")
              location = get_or_create_location(eventLocationArray)
            
              if(location != nil) then
              
                #get or create the venue
                venue_name = event.at("name").inner_html
                venue_address = event.at("street").inner_html
                venue_phone_number = event.at("phonenumber").inner_html
                venue_website = event.at("website").inner_html
                venue = get_or_create_venue(location, venue_name, venue_address, venue_phone_number, venue_website)
              
                if(venue != nil) then
                
                  headliner = event.at("headliner").inner_html
                
                  showDateArray = event.at("startDate").inner_html.split(" ")
                  dateString = showDateArray.at(1) + showDateArray.at(2) + showDateArray.at(3)
                  newDate = Date.parse(dateString)
                  show = see_if_show_already_exists(location, headliner, newDate)
                
                  #create show if doesn't already exist
                  if(show == nil) then
                     newShow = Show.new
                   
                     #add artists
                     (event/:artist).each do |artist|
                       newShow.add_band_to_show(artist.inner_html)
                     end
                   
                     #posted by me
                     newShow.posted_by = 1
                   
                     #date
                     newShow.date = newDate
                   
                     #description
                     description = event.at("description").inner_html
                     if(description != "") then
                       newShow.additional_info = description[9..-4]
                     end
                   
                     #last_fm_event_id
                     newShow.last_fm_event_id = event_id
                   
                     #add showtime
                    newShow.time = "UNKNOWN"
                    newShow.allowed_in = "UNKNOWN"
                    newShow.price_option = "UNKNOWN"
                  
                    #save show
                    newShow.save
                   
                    location.add_show_to_location(newShow)
                    venue.add_show_to_venue(newShow)
                  
                     location.save
                     venue.save

                  end

                end

              
              end
               

            end

       end #event loop
       
       self.shows_last_grabbed = Date.current
       self.save

    end
        
      rescue OpenURI::HTTPError
        logger.error("Unable to get shows for #{band_name} from last.fm")
  end
  
  
  
private

  def see_if_show_already_exists(location, headliner, date)
    headliner = headliner.gsub('&amp;', '&')
    locationShows = location.shows.date_equals(date)
    locationShows.each do |show|
      band = show.bands.band_name_equals(headliner.upcase).first
      if(band !=  nil) then
        return show
      end
    end
    
   return nil

  end

  def get_or_create_venue(location, venue_name, venue_address, phone_number, website)
    
    #first see if venue exists at location
    #if it doesn't create
    venues = location.venues
    venue = venues.name_equals(venue_name.upcase).first
    
    if(venue == nil) then 
      venue = venues.name_equals("THE "+ venue_name.upcase).first
    end
    
    if(venue == nil) then
      if(venue_address != "" && venue_address != nil) then
        venue = venues.address_equals(venue_address.upcase).first
      end
    end
    
    if(venue == nil) then
      newVenue = Venue.new
      newVenue.name = venue_name.upcase
      if(venue_address != nil) then
        newVenue.address = venue_address
      end
      
      if(phone_number != "") then
        newVenue.phone = phone_number
      end
      
      if(website != "") then 
        newVenue.website = website
      end
      
      location.add_venue_to_location(newVenue)
      newVenue.save
      
      return newVenue
    else
      return venue
    end
    
    return nil
    
  end
  
  def get_or_create_location(eventLocationArray)
    
    state_hash = {
      'ALABAMA'=>'AL',
      'ALASKA'=> 'AK',
      'ARIZONA'=> 'AZ',
      'ARKANSAS'=> 'AR',
      'CALIFORNIA'=> 'CA',
      'COLORADO'=> 'CO',
      'CONNECTICUT'=> 'CT',
      'DELAWARE'=> 'DE',
      'DISTRICT OF COLUMBIA'=> 'DC',
      'FLORIDA'=> 'FL',
      'GEORGIA'=> 'GA', 
      'HAWAII'=> 'HI',
      'IDAHO'=> 'ID',
      'ILLINOIS'=> 'IL',
      'IOWA'=> 'IA',
      'KANSAS'=> 'KS',
      'KENTUCKY'=> 'KY',
      'LOUISIANA'=> 'LA',
      'MAINE'=> 'ME',
      'MARYLAND'=> 'MD',
      'MASSACHUSETTS'=> 'MA',
      'MICHIGAN'=> 'MI',
      'MINNESOTA'=> 'MN',
      'MISSISSIPPI'=> 'MS',
      'MISSOURI'=> 'MO',
      'MONTANA'=> 'MT',
      'NEBRASKA'=> 'NE',
      'NEVADA'=> 'NV',
      'NEW HAMPSHIRE'=> 'NH',
      'NEW JERSEY'=> 'NJ',
      'NEW MEXICO'=> 'NM',
      'NEW YORK'=> 'NY',
      'NORTH CAROLINA'=> 'NC',
      'NORTH DAKOTA'=> 'ND',
      'OHIO'=> 'OH',
      'OKLAHOMA'=> 'OK',
      'OREGON'=> 'OR',
      'PENNSYLVANIA'=> 'PA',
      'PUERTO RICO'=> 'PR',
      'RHODE ISLAND'=> 'RI',
      'SOUTH CAROLINA'=> 'SC',
      'SOUTH DAKOTA'=> 'SD',
      'TENNESSEE'=> 'TN',
      'TEXAS'=> 'TX',
      'UTAH'=> 'UT',
      'VERMONT'=> 'VT',
      'VIRGINIA'=> 'VA',
      'WASHINGTON'=> 'WA',
      'WEST VIRGINIA'=> 'WV',
      'WISCONSIN'=> 'WI',
      'WYOMING' => 'WY', 
      'BRITISH COLUMBIA' => "BC",
      'ALBERTA' => "AB",
      'MANITOBA' => "MB",
      'NEW BRUNSWICK' => "NB",
      'NEWFOUNDLAND AND LABRADOR' => "NL", 
      'NORTHWEST TERRITORIES' => "NT", 
      'NOVA SCOTIA' => "NS", 
      'NUNAVUT' => "NU", 
      'ONTARIO' => "ON", 
      'PRINCE EDWARD ISLAND' => "PE", 
      'QUEBEC' => "QC", 
      'SASKATCHEWAN' => "SK", 
      'YUKON' => "YT"    
    }
    
    if(eventLocationArray.length > 0) then
      location = Location.city_equals(eventLocationArray.at(0).upcase)
      if(eventLocationArray.at(1) != nil) then
        state = eventLocationArray.at(1)
        if(state.lstrip.length > 2) then
          state = state_hash[state.lstrip.upcase]
        end
        if(state != nil) then
          location = location.state_equals(state.lstrip.upcase)
        end
      end
    
      location = location.first
    
      if(location == nil) then
        newLocation = Location.new
        newLocation.city = eventLocationArray.at(0).upcase
        if(eventLocationArray.at(1) != nil) then
          state = eventLocationArray.at(1)
          if(state.lstrip.length > 2) then
            state = state_hash[state.lstrip.upcase]
          end
          if(state != nil) then
            newState = state.lstrip
            newLocation.state = newState
            newLocation.save
            return newLocation
          else
            return nil
          end
        end
      else
        return location
      end
      
    end
    
    return nil
    
  end
  
end
