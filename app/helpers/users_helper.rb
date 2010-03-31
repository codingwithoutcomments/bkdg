module UsersHelper
  
  def attending_attended_posted?(sort_by, tab_name)
    if(sort_by == "attended" && tab_name == "attended") then
      return "youarehere"
    elsif ((sort_by == "attending" || sort_by == nil) && tab_name == "attending")
      return "youarehere"
    elsif (sort_by == "posted" && tab_name == "posted")
      return "youarehere"
    else
      return ""
    end
  end
  
  def return_follow_text(user)
    return 'Follow '+ user.username + ' »'
  end
  
end
