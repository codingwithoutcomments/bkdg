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
   
end