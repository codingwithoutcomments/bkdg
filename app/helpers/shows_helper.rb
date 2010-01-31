module ShowsHelper
  def is_primary_tab?(tab_name, primary_tab_name)
    if(tab_name == primary_tab_name || primary_tab_name == nil)
      return "youarehere"
    else
      return ""
    end
  end

  def attending_counts_helper(attending_count)
    if(attending_count.to_i > 99)
      return "h3"
    else
      return "h2"
    end
  end
  
  def comment_counts_helper(comment_count)
    if(comment_count.to_i > 99)
      return "h3"
    else
      return "h2"
    end
  end
  
  def firstShowOnDate(previousDate, show)
    if (previousDate == nil ||  show.date.strftime("%b %e") != previousDate.strftime("%b %e"))
      return true
    else
      return false
    end
  end
  
  def generate_two_random_band_pictures(show)
    
    randomNumbers = []
    firstRandomNumber = rand(show.bands.at(0).bandpictures.count)
    randomNumbers << firstRandomNumber
    begin
      secondRandomNumber = rand(show.bands.at(0).bandpictures.count)
    end while secondRandomNumber == firstRandomNumber
    
    randomNumbers << secondRandomNumber
    
    return randomNumbers
    
  end
  
  def capitalize_first_letter_of_each_word(input)
    output = ""
    input = input.split(" ")
    input.each {|word| output += word.capitalize + " " }
    output.strip!
    
    return output;
  end
  
  def attending_highlight_helper(user_logged_in,shows_attending, show)
    if(user_logged_in)
        shows_attending.each do |show_attending|
          if(show_attending.id.to_s == show.id.to_s)
            @attendingshow = true
            return "show-summary-attending"
          end
        end
        @attendingshow = false
        return "show-summary"
        
      else
        @attendingshow = false
        return "show-summary"
      end
  end
  
  def map_it(show)
  end
  
  def attendingshow?
    if (@attendingshow)
      return "Attending"
    else
      return "Attend"
    end
  end
  
  def attendingTheShow?
    if (@attendingshow)
      return "You Are Attending The Show.  Click To Back Out."
    else
      return "Gonna go?  Click To Attend."
    end
  end
  
  def getAttendStyle
    if (@attendingshow)
      return "attendingtheshow"
    else
      return ""
    end
  end
  
  def populate_headliner(show)
    return show.bands.at(0).band_name
  end
  
  def populate_openers(show)
    if(show.bands.count > 1)
      openers = ""
      1.upto(show.bands.count - 2) { |i| openers += show.bands.at(i).band_name + ", " }
      openers += show.bands.at(show.bands.count - 1).band_name
      return openers
    end
  end
  
end
