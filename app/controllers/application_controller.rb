# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #before_filter :authorize, :except => :login
  before_filter :set_city
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'fd6ace83b5d1b8c9d0ab1418ed139c28'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
   filter_parameter_logging :password
   
protected

  def authorize
    unless User.find_by_id(session[:admin_id])
      session[:original_uri] = request.request_uri
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
  
  def set_city
    session[:city] = "Seattle"
    session[:state] = "Washington"
  end
  
end
