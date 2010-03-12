class LocationsController < ApplicationController

  def index
      @locations = Location.all.sort_by{|p| p.city.downcase}
      
  end

  def show
    @location = Location.city_equals(params[:city]).first

    session[:city] = @location.city
    session[:state] = @location.state

    respond_to do |format|
      
        format.html { redirect_to :controller => 'shows', :action => 'index', :city => capitalize_first_letter_of_each_word(@location.city) }
        format.xml  { render :xml => @show }
      
    end
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