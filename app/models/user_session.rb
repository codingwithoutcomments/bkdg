class UserSession < Authlogic::Session::Base  
  remember_me true
  def remember_me_for     
    1.month
  end
end