class LoginController < ApplicationController
  
  def index
      if request.post?
        user = User.authenticate(params[:name], params[:password])
        if user
          session[:user_id] = user.id
          uri = session[:original_uri]
          session[:original_uri] = nil
          redirect_to(uri || {:controller => 'shows', :action => 'index' })
        else
          flash.now[:notice] = "Invalid user/password combination"
        end
      end
  end
  
  def logout
    if(session[:user_id])
      user = User.find(session[:user_id])
      flash[:notice] = "Logged out of #{user.username}"
      session[:user_id] = nil
      redirect_to :controller =>'shows', :action => 'index'
    else
      redirect_to :controller =>'shows', :action => 'index'
    end
  end

end
