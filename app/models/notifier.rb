 class Notifier < ActionMailer::Base
   
  # def contact(recipient, subject, message, sent_at = Time.now, header)
  #       @subject = subject
  #       @recipients = recipient
  #       @from = 'no-reply@yourdomain.com'
  #       @sent_on = sent_at
  # 	  @body["title"] = 'This is title'
  #   	  @body["email"] = 'sender@yourdomain.com'
  #    	  @body["message"] = message
  #       @headers["X-SMTPAPI"] = header
  #    end
   
     
    default_url_options[:host] = "badkidsdancegood.com"  
   
    def password_reset_instructions(user) 
      
         subject       "Bad Kids Password Reset Instructions"  
         from          "noreply@badkidsdancegood.com"  
         recipients    user.email  
         sent_on       Time.now  
         body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
   end  
   
end