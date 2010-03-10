class LocationController < ApplicationController

  def index
      respond_to do |format|
          format.js
       end
  end

  def update
  
    respond_to do |format|
        format.js
     end
  end
   
end