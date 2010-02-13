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
  
  def format_price(price)
    integerPrice = price.to_i
    if(price > integerPrice.to_i) then
      return(sprintf("%.2f", price))
    else
      return integerPrice
    end
  end
  
  def format_price_label(show, price)
    if(show.price_option == "MONEY")
      if(price != nil) then
          return sprintf("%.2f", price)
      else
          return ""
      end
    else
      return price
    end
  end
  
  def didwhen(old_time)

    val = Time.now - old_time
    #puts val
    if val < 10 then
      result = 'just a moment ago'
    elsif val < 40  then
      result = 'less than ' + (val * 1.5).to_i.to_s.slice(0,1) + '0 seconds ago'
    elsif val < 60 then
      result = 'less than a minute ago'
    elsif val < 60 * 1.3  then
      result = "1 minute ago"
    elsif val < 60 * 50  then
      result = "#{(val / 60).to_i} minutes ago"
    elsif val < 60  * 60  * 1.4 then
      result = 'about 1 hour ago'
    elsif val < 60  * 60 * (24 / 1.02) then
      result = "about #{(val / 60 / 60 * 1.02).to_i} hours ago"
    elsif val < 60  * 60 * (48 / 1.02) then
        result = "about 1 day ago"
    elsif val < 60  * 60 * (72 / 1.02) then
            result = "about 2 days ago"
    elsif val < 60  * 60 * (96 / 1.02) then
            result = "about 3 days ago"
    else
      result = old_time.strftime("%b %d, %Y %H:%M")

    end
    result
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
  
  def map_it(show)
    link = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q="
    link = link + show.venue.address.gsub(' ','+') if show.venue.address != nil
    link = link + "+" + show.location.city + "+" + show.location.state
    return link
  end
  
  def attendingshow?
    if (@attendingshow)
      return "You Are Attending This Show"
    else
      return "Click To Attend This Show"
    end
  end
  
  def attendingTheShow?
    if (@attendingshow)
      return "You Are Attending This Show."
    else
      return "Are you going?  Click To Attend."
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
    return capitalize_first_letter_of_each_word(show.bands.at(0).band_name)
  end
  
  def populate_openers(show)
    if(show.bands.count > 1)
      openers = ""
      1.upto(show.bands.count - 2) { |i| openers += capitalize_first_letter_of_each_word(show.bands.at(i).band_name) + ", " }
      openers += capitalize_first_letter_of_each_word(show.bands.at(show.bands.count - 1).band_name)
      return openers
    end
  end
  
end
