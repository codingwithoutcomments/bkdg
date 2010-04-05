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
    puts val
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
      result = old_time.strftime("%b %d, %Y")

    end
    result
    
    #time_ago_in_words(old_time, include_seconds = false) + " ago"
  end

  
  def attending_helper
  
      if (@attendingshow)
        return "attendingtheshow"
      else
        return "notattendingtheshow"
      end
  end
  
  def retrieve_friends_attending(show, current_user)
    
    @friends_attending = []
    @non_friends_attending = []
    
   @showUsers = show.users
   0.upto(@showUsers.length - 1) { |i|
       @friendshipExists = current_user.friendships.friend_id_equals(show.users.at(i).id).first
       if(@friendshipExists != nil || show.users.at(i).id == current_user.id) then
         @friends_attending << show.users.at(i)
        else
          if(show.users.at(i).id != current_user.id) then
            @non_friends_attending << show.users.at(i)
          end
        end
        
    }
    
  end
  
  def number_of_friends_attending(show, current_user)
    @i = 0
    attendingString = ""
    if(show.users.length > 0) then
      for friendship in current_user.friendships
        attending = show.users.id_equals(friendship.friend.id).first
        if(attending != nil) then 
          @i = @i + 1 
        end
      end
    end
    
    @youAreAtteding = show.users.id_equals(current_user.id).first
    
    if(@i > 0)
      attendingString = attendingString + pluralize(@i, "friend")
    end
    
    if(@youAreAtteding)
      if(@i == 0) then
        #attendingString = attendingString + "You Are Attending"
      else
        attendingString = attendingString + " and you"
      end
    end
    
    if(@i > 0 || @youAreAtteding == true )
      if(@i == 1 && @youAreAtteding == nil) then
        attendingString = attendingString + " is attending"
      else
        attendingString = attendingString + " are attending"
      end
    end
    
    return attendingString
  end
  
  def map_it(show)
    link = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q="
    link = link + show.venue.get_address_parameterized if show.venue.address != nil
    link = link + "+" + show.location.get_city_parameterized + "+" + show.location.state
    return link
  end
  
  
  def attendingTheShow?
    if (@attendingshow)
      return "You Are Attending This Show."
    else
      return "You in brah?  Click To Attend."
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
