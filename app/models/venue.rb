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
  
  validates_presence_of :name
  validates_presence_of :address
  
   validate :unqiueness_of_venue_name_in_city
   
   def to_param
     "#{id}-#{name.downcase.parameterize}"
   end
  
  def add_show_to_venue(show)
    shows << show
  end
  
  def remove_show_from_venue(show)
    shows.delete(show)
  end
  
  def get_address_parameterized()

    tempAddress = address
    tempAddress = tempAddress.gsub('+', '%2B')
    tempAddress = tempAddress.gsub(' ', '+')
    tempAddress = tempAddress.gsub('&', '%26')
    tempAddress = tempAddress.gsub('$', '%24')
    tempAddress = tempAddress.gsub(',', '%2C')
    tempAddress = tempAddress.gsub('/', '%2F')
    tempAddress = tempAddress.gsub(':', '%3A')
    tempAddress = tempAddress.gsub(';', '%3B')
    tempAddress = tempAddress.gsub('=', '%3D')
    tempAddress = tempAddress.gsub('?', '%3F')
    tempAddress = tempAddress.gsub('@', '%40')
    
    return tempAddress
  end
  
private

  def unqiueness_of_venue_name_in_city
    
    @location = Location.id_equals(location_id).first
    @venuesAtLocation = @location.venues
    
    @venue =  @venuesAtLocation.name_equals(name.upcase).first
    
    if(@venue != nil && @venue.id != id)  then 
      errors.add_to_base(capitalize_first_letter_of_each_word(name) + " already exists in " + @location.city + ", " + @location.state)
    end
      
  end
  
  def capitalize_first_letter_of_each_word(input)
    output = ""
    input = input.split(" ")
    input.each {|word| output += word.capitalize + " " }
    output.strip!
    
    return output;
  end
  
  
  
end
