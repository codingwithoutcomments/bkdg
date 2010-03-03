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
  
  def days_away_helper(showDate)
    
      year = showDate.strftime("%Y")
      month = showDate.strftime("%m")
      day = showDate.strftime("%e")
      showDate = Date.new(year.to_i, month.to_i, day.to_i)
      
      val = showDate - DateTime.now
      
      #puts val
      if val.to_i == -1 then
        result = 'Today'
      elsif val.to_i == 0 then
        result = 'Tomorrow'
      else
        result = (val.to_i + 2).to_s + " Days Away" 

      end
      result
  end
  
end
