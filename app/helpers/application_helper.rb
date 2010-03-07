# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def capitalize_first_letter_of_each_word(input)
    output = ""
    input = input.split(" ")
    input.each {|word| output += word.capitalize + " " }
    output.strip!
    
    return output;
  end
  
  def attending_click_helper(user_logged_in,shows_attending, show)
    if(user_logged_in)
        shows_attending.each do |show_attending|
          if(show_attending.id.to_s == show.id.to_s)
            @attendingshow = true
            return "alreadyattending"
          end
        end
        @attendingshow = false
        return "notattending"
        
      else
        @attendingshow = false
        return "notattending"
      end
  end
  
  def attending_highlight_helper(user_logged_in,shows_attending, show)
    if(user_logged_in)
        attending = shows_attending.id_equals(show.id).first
        if(attending == nil)
          @attendingshow  = false
        else
          @attendingshow = true
        end
        
        return "show-summary"
        
      else
        @attendingshow = false
        return "show-summary"
      end
  end
  
  def attendingshow?
    if (@attendingshow)
      return "Remove This Show From My List"
    else
      return "Click To Attend This Show"
    end
  end
  
  def days_away_helper(showDate, showtime)
      hoursToAdd = CalculateHoursToAdd(showDate, showtime)
      return distance_of_time_in_words(showDate + hoursToAdd, Time.now, include_seconds = false)
  end
  
  def away_or_ago_helper(showDate, showtime)
    hoursToAdd = CalculateHoursToAdd(showDate, showtime)
    difference = Time.now - (showDate + hoursToAdd)
    
    if(difference < 0)
      return "away"
    else
      return "ago"
    end
    
  end
  
  def CalculateHoursToAdd(showDate, showtime)
      hoursToAdd = 20.hours
      if(showtime == "UNKNOWN") then 
        hoursToAdd = 20.hours
      else
        hour = showtime.at(0)
        halfhour = showtime.at(2)
        dayNight = showtime[-2..-1]
        if(dayNight == "AM") then
          hoursToAdd = hour.to_i.hours
        else
          hoursToAdd = hour.to_f + 12.0
          if(halfhour == "3") then
            hoursToAdd = hoursToAdd + 0.5
          end
          hoursToAdd = hoursToAdd.hours
        end
    end
  end
  
  
  
  
end
