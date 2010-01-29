require 'erb'
require 'open-uri'
require 'rubygems'
require 'hpricot'


class ShowsController < ApplicationController
  
  # GET /shows
  # GET /shows.xml
  def index
      city = getCityOfUser()
      state = getStateOfUser()
      
      location = Location.find(:first, :conditions => ["city = ? and state = ?", city, state])
      @shows = location.shows.find(:all, :conditions => ['date > ?', Date.current - 1.day ], :order => 'date ASC, attending DESC')
    
     set_current_user_if_logged_in()
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shows }
    end
  end
  
  def need_to_be_logged_in
    @attendrecommend = ".attend-recommend"
    respond_to do |format|
         format.js
    end
  end
  
  def venue_description(venue)
  end

  # GET /shows/1
  # GET /shows/1.xml
  def show
    @show = Show.find(params[:id])
    @comments = @show.comments
    @bands = @show.bands
    @headliner = Band.find(@bands.at(0).id)
    
    #check to see if the band has any pictures available for display
    #if not then retrieve the links from last.fm
    if(!@headliner.has_pictures?)  
      retrieve_pictures(@headliner) 
    end
    
    set_current_user_if_logged_in()
    
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid show #{params[:id]}")
      flash[:notice] = "Invalid Show"
      redirect_to :action => 'index'
  end
  
  def LeaveComment
    
    #create a new comment
    @comment = Comment.new
    user_comment = params[:comment]
    #comment_to_insert = ERB::Util.html_escape(params[:comment]) 
    @comment.user_comment = user_comment
    
    #add the comment to the user
    @user = get_current_user
    @user.add_comment_to_user(@comment)
    @user.save
    
    #add the comment to the show
    @show = Show.find(params[:id])
    @show.add_comment_to_show(@comment)
    @show.save
    
    respond_to do |format|
         format.js
    end
    
  end

  # GET /shows/new
  # GET /shows/new.xml
  def new
    @userCity = getCityOfUser()
    @userState = getStateOfUser()
    @show = Show.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # GET /shows/1/edit
  def edit
    @show = Show.find(params[:id])
  end
  
  # POST /shows
  # POST /shows.xml
  def create
    @userCity = getCityOfUser()
    @userState = getStateOfUser()
    @venueName = params[:name_of_venue]
    
    @location = Location.find(:first, :conditions => ["city = ? and state = ?", @userCity, @userState])
    
    @show = Show.new(params[:show])
    
    if(@venueName == "")  then @show.throw_error("How will there be a show without a venue?") end
    
    @form_band_list_array = [:band1, :band2, :band3, :band4, :band5, :band6, :band7, :band8, :band9, :band10]
    @band_array = []
    @form_band_list_array.each do |form_element|
      if(params[form_element] != '') 
        @show.add_band_to_show(params[form_element])  
        @band_array.push(params[form_element])
      end
    end
    
    respond_to do |format|
      
      @venue = Venue.find(:first, :conditions=> ["name = ?", @venueName] )
      
      debugger()
      
     if @show.errors.size > 0
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
        
      elsif @show.save
        
        @venue.add_show_to_venue(@show)
        @venue.save
        
        @location.add_show_to_location(@show)
        @location.save
        
        flash[:notice] = 'Show was successfully created.'
        format.html { redirect_to(@show) }
        format.xml  { render :xml => @show, :status => :created, :location => @show }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shows/1
  # PUT /shows/1.xml
  def update
    @show = Show.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        flash[:notice] = 'Show was successfully updated.'
        format.html { redirect_to(@show) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def search
  end

  # DELETE /shows/1
  # DELETE /shows/1.xml
  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end
  
  def increment_attending
    
    @on_show_detail_page = params[:show_detail_page]
    
    #check first to see if already attending show
    if already_attending?(params[:user_id], params[:id])
      @show = Show.find(params[:id])
      @current_show = @show
      @show.attending = @show.attending - 1
      @show.user_not_attending(get_current_user())
      
      @show.save
      @attending_show_already = true
    else
      
      @attending_show_already = false
      
      @show = Show.find(params[:id])
      @show.attending = @show.attending + 1
      @show.user_attending(get_current_user())
      @show.save
      @current_show = @show
      
    end
    
     respond_to do |format|
        format.js
     end
    
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid show #{params[:id]}")
      flash[:notice] = "Invalid Show"
      redirect_to :action => 'index'
  end
  
  def venue_changed
    
     city = getCityOfUser()
     state = getStateOfUser()
    
     @venueFound = "false"
     @isPartialMatch = "false"
     @MatchName = ""
     
     @venueName = params[:venueName]
     
     @location = Location.find(:first, :conditions => ["city = ? and state = ?", city, state])
     @venue = Venue.find(:first, :conditions => ["name = ? and location_id = ?", @venueName.upcase, @location.id] )

     if(@venue == nil) then 
       
       @venueFound = "false"
       
       venueNameModified = formatVenueNameForSearch(@venueName)
       @PartialMatch = Venue.name_like(venueNameModified);
       if(@PartialMatch.length > 0) then 
         @isPartialMatch = "true" 
         @MatchName = capitalize_first_letter_of_each_word(@PartialMatch.at(0).name)
         
       end
       
      else 
         @venueFound = "true" 
     end

     respond_to do |format|
       format.js
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

  def formatVenueNameForSearch(venueName)
    venueName = venueName.gsub("the", "")
    venueName = venueName.gsub("The", "")
    venueName = venueName.gsub("THE", "")
    
    venueName.strip!
    
    return venueName
  end

  def getCityOfUser
    session[:city]
  end
  
  def getStateOfUser
    session[:state]
  end

  def already_attending?(user_id, show_id)
    user = get_current_user
    shows_that_user_is_attending = user.shows
    shows_that_user_is_attending.each do |attending_show|
      if(show_id.to_s == attending_show.id.to_s) 
        return true
      end
        
    end    
    
    return false;
  end
  
  def get_current_user
    
    if(session[:user_id])
      @current_user = User.find(session[:user_id])
    end
    
    return @current_user
  end
  
  def retrieve_pictures(headliner)
    headliner_sans_spaces = headliner.band_name.gsub(' ', '+')
    last_fm_get_picture_string = "http://ws.audioscrobbler.com/2.0/?method=artist.getimages&artist=" + headliner_sans_spaces + "&api_key=7a8a93a66b33946440ad048191c80609"
    doc = Hpricot.XML(open(last_fm_get_picture_string))
      (doc/:sizes).each do |sizes|
        picture = Bandpicture.new
        picture.original = sizes.at("size[@name='original']").inner_html
        picture.large = sizes.at("size[@name='large']").inner_html
        picture.largesquare = sizes.at("size[@name='largesquare']").inner_html
        picture.medium = sizes.at("size[@name='medium']").inner_html
        picture.small = sizes.at("size[@name='small']").inner_html
        picture.save
        headliner.add_picture_to_band(picture)
      end
  end
  
  def set_current_user_if_logged_in
    if(session[:user_id])
      @current_user = User.find(session[:user_id])
      @shows_that_user_is_attending = @current_user.shows
    end
  end

end
