# == Schema Information
# Schema version: 20091207050051
#
# Table name: shows
#
#  id           :integer         not null, primary key
#  date         :date
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  price        :decimal(, )
#  showtime     :time
#  attending    :integer         default(0)
#  time         :string(255)
#  location_id  :integer
#  venue_id     :integer
#  advanceprice :decimal(8, 2)
#

class Show < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :bands
  belongs_to :location
  belongs_to :venue
  has_many :comments
  
  SHOW_TIMES = [['11:30 PM', '11:30 PM'], ['11:00 PM', '11:00 PM'], ['10:30 PM', '10:30 PM'], ['10:00 PM', '10:00 PM'], ['10:00 PM', '10:00 PM'], ['09:30 PM', '9:30 PM'], ['09:00 PM', '9:00 PM'], ['08:30 PM', '8:30 PM'], ['08:00 PM', '8:00 PM'], ['07:30 PM', '7:30 PM'], ['07:00 PM', '7:00 PM'], ['06:30 PM', '6:30 PM'], ['06:00 PM', '6:00 PM'], ['05:30 PM', '5:30 PM'], ['05:00 PM', '5:00 PM'] , ['04:30 PM', '4:30 PM'], ['04:00 PM', '4:00 PM'], ['03:30 PM', '3:30 PM'], ['03:00 PM', '3:00 PM'], ['02:30 PM', '2:30 PM'], ['02:00 PM', '2:00 PM'], ['01:30 PM', '1:30 PM'], ['01:00 PM', '1:00 PM'], ['12:30 PM', '12:30 PM'], ['12:00 PM', '12:00 PM'], ['11:30 AM', '11:30 AM'], ['11:00 AM', '11:00 AM'], ['10:30 AM', '10:30 AM'], ['10:00 AM', '10:00 AM'], ['9:30 AM', '9:30 AM'], ['10:00 AM', '10:00 AM'], ['09:30 AM', '9:30 AM'], ['09:00 AM', '9:00 AM'], ['08:30 AM', '8:30 AM'], ['08:00 AM', '8:00 AM'], ['07:30 AM', '7:30 AM'], ['07:00 AM', '7:00 AM'], ['06:30 AM', '6:30 AM'], ['06:00 AM', '6:00 AM'], ['05:30 AM', '5:30 AM'], ['05:00 AM', '5:00 AM'] , ['04:30 AM', '4:30 AM'], ['04:00 AM', '4:00 AM'], ['03:30 AM', '3:30 AM'], ['03:00 AM', '3:00 AM'], ['02:30 AM', '2:30 AM'], ['02:00 AM', '2:00 AM'], ['01:30 AM', '1:30 AM'], ['01:00 AM', '1:00 AM'], ['12:30 AM', '12:30 AM'], ['12:00 AM', '12:00 AM']]
  validate :price_greater_than_zero_or_free
  validate :advance_price_greater_than_zero_or_free
  validate :has_at_least_one_band_playing
  
  def add_comment_to_show(comment_to_add)
    comments << comment_to_add
  end
  
  def remove_comment_from_show(comment_to_remove)
    comments.delete(comment)
  end
  
  def add_band_to_show(band_to_add)
    band = Band.find(:first, :conditions => ["band_name = ?", band_to_add])
    if(band == nil)
      band = Band.new(:band_name => band_to_add) 
      band.save
    end
    bands << band
  end
  
  def remove_band_from_show(band)
    bands.delete(band)
  end
  
  def user_attending(user)
    users << user
  end
  
  def user_not_attending(user)
    users.delete(user)
  end
  
  def throw_error(error)
    errors.add(error, '')
  end
  
  protected
  
  def has_at_least_one_band_playing
    if(bands.size == 0)
      errors.add("How can there be a show without any bands?", "")
    end
  end
  
  def advance_price_greater_than_zero_or_free
    if !advanceprice.nil?
        if(is_numeric?(advanceprice) == false) then
          errors.add("The advanced price you have entered is not valid.", '') 
        end
    end
  end
  
    def price_greater_than_zero_or_free
      if !price.nil?
          if(is_numeric?(price) == false) then
            errors.add(:price, ' not valid') 
          end
      end      
    end
    
    def is_numeric?(s)
     
      isMatch = false
      #first check to make sure > 0.01
      s.to_s.match(/^\d+\.\d$/) == nil ? isMatch = false : isMatch = true;
      
      #then see if costs nothing
      if(s.to_s == "0.0") then isMatch = true; end
    
      tempString = "This Price " + s.to_s + " is a match " + isMatch.to_s
      
      return isMatch
    end
    
end
