class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    @current_user = current_user
    @venue = Venue.find(params[:id])
    @venueLocation = @venue.location
    @venueShows = @venue.shows.find(:all, :conditions => ['date > ?', Date.current - 1.day ], :order => 'date ASC, attending DESC')
    
    @venueMapLink = "http://maps.google.com/maps/api/staticmap?center="+ @venue.get_address_parameterized + "+" + @venue.location.get_city_parameterized + "+" + @venue.location.state 
    @venueMapLink = @venueMapLink +"&zoom=15&size=320x320&maptype=roadmap&markers=color:blue|label:*|" 
    @venueMapLink = @venueMapLink + @venue.get_address_parameterized + "+" 
    @venueMapLink = @venueMapLink + @venue.location.get_city_parameterized 
    @venueMapLink = @venueMapLink + "+"+ @venue.location.state + "&sensor=false"
    
    set_current_user_if_logged_in()

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new
    
    @userCity = get_user_city()
    @userState = get_user_state()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])
    
    if(@venue.name != nil) then
      @venue.name = @venue.name.upcase
    end
    
    @userCity = get_user_city()
    @userState = get_user_state()
    
    @location = Location.city_equals(@userCity).state_equals(@userState).first
    @venue.location_id = @location.id
    
    respond_to do |format|
      if @venue.save
        
        @location.add_venue_to_location(@venue)
        @location.save
        
        flash[:notice] = 'Venue was successfully created.'
        format.html { redirect_to(@venue) }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        flash[:notice] = 'Venue was successfully updated.'
        format.html { redirect_to(@venue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
end

private

def set_current_user_if_logged_in
  if(current_user)
    @shows_that_user_is_attending = current_user.shows
  end
end
