 class Notifier < ActionMailer::Base
     
    default_url_options[:host] = "badkidsdancegood.com"  
   
    def password_reset_instructions(user) 
      
         subject       "Bad Kids Password Reset Instructions"  
         from          "noreply@badkidsdancegood.com"  
         recipients    user.email  
         sent_on       Time.now
         content_type "text/html"
         body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
   end
   
   def comment_to_show_poster(show, comment, userWhoPostedShow)
       subject comment.user.username + " commmented on a show you posted"
       from "noreply@badkidsdancegood.com"
       recipients userWhoPostedShow.email
       sent_on Time.now
       content_type "text/html"
       body :comment => comment.user_comment, :user_who_commented => comment.user.username, :headliner => capitalize_first_letter_of_each_word(show.bands.at(0).band_name), :show_url => show_url(show)
   end
   
   def comment_to_other_commenters(show, comment, userWhoPostedShow, emailAddress)
     subject comment.user.username + " commented on the " + capitalize_first_letter_of_each_word(show.bands.at(0).band_name) + " show that " + userWhoPostedShow.username + " posted"
     from "noreply@badkidsdancegood.com"
     recipients emailAddress
     sent_on Time.now
     content_type "text/html"
     body :comment => comment.user_comment, :user_who_commented => comment.user.username, :headliner => capitalize_first_letter_of_each_word(show.bands.at(0).band_name), :show_url => show_url(show), :user_who_posted_show => userWhoPostedShow.username
  end
   
private

  def capitalize_first_letter_of_each_word(input)
    output = ""
    input = input.split(" ")
    input.each {|word| output += word.capitalize + " " }
    output.strip!
    
    return output;
  end
   
end