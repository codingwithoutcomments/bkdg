module VenuesHelper
  
  def verify_has_http(venueWebsite)
    debugger()
    if(venueWebsite != "") then
      if(venueWebsite.at(0) != "h" && venueWebsite.at(2) != "p") then 
        return "http://" + venueWebsite
      end
    end
    
    return venueWebsite
  end
end
