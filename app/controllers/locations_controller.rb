class LocationsController < ApplicationController

  def index
      @locations = Location.all.sort_by{|p| p.city.downcase}
      
  end

  def show
    @location = Location.city_equals(params[:city]).first

    session[:city] = @location.city
    session[:state] = @location.state

    respond_to do |format|
      
        format.html { redirect_to :controller => 'shows', :action => 'index' }
        format.xml  { render :xml => @show }
      
    end
  end
   
end