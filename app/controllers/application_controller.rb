# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_city
  helper :all # include all helpers, all the time
  helper_method :current_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'fd6ace83b5d1b8c9d0ab1418ed139c28'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
   filter_parameter_logging :password
   
protected

  #def authorize
  #  return if self.controller_name == 'login'
  #  unless current_user
  #    session[:original_uri] = request.request_uri
  #    redirect_to :controller => 'login'
  #  end
  #end
  
   def current_user_session  
     return @current_user_session if defined?(@current_user_session)  
     @current_user_session = UserSession.find  
   end  
     
   def current_user  
     @current_user = current_user_session && current_user_session.record  
   end
   
   def require_user
         unless current_user
           store_location
           flash[:notice] = "You must be logged in to access this page"
           redirect_to new_user_session_url
           return false
         end
       end

       def require_no_user
         if current_user
           store_location
           flash[:notice] = "You must be logged out to access this page"
           redirect_to account_url
           return false
         end
       end

       def store_location
         session[:return_to] = request.request_uri
       end

       def redirect_back_or_default(default)
         redirect_to(session[:return_to] || default)
         session[:return_to] = nil
       end
  
  def set_city
    session[:city] = "Seattle"
    session[:state] = "Washington"
  end
  
  def get_user_city
    return session[:city]
  end
  
  def get_user_state
    return session[:state]
  end
  
end
