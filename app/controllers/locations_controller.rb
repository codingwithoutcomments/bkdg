class LocationsController < ApplicationController

  def index
      @locations = Location.all.sort_by{|p| p.city.downcase}
      
  end

  def show
    
    @location = Location.find(params[:id])

    session[:city] = @location.city
    session[:state] = @location.state

    respond_to do |format|
      
        format.html { redirect_to :controller => 'shows', :action => 'index', :city => capitalize_first_letter_of_each_word(@location.city), :state => @location.state}
        format.xml  { render :xml => @show }
      
    end
  end
  
  def route_to_location
    respond_to do |format|
        format.html { redirect_to :controller => 'shows', :action => 'index', :city => capitalize_first_letter_of_each_word(session[:city]), :state => session[:state]}
    end
  end
  
  def byState
    @state = params[:state]
    @locations = Location.state_equals(@state.upcase).sort_by{|p| p.city.downcase }
    
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