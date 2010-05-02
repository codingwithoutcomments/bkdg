class SearchController < ApplicationController
  # GET /searches
  # GET /searches.xml
  def index
    
    searchQuery = params[:q]
    searchQuery = searchQuery.strip
    
    searchObject = Search.new
    searchObject.search_text = searchQuery
    searchObject.save
    
    city = get_user_city
    state = get_user_state
    
    @location = Location.find(:first, :conditions => ["city = ? and state = ?", city.upcase, state.upcase])
    @allShows = @location.shows.find(:all, :conditions => ['date > ?', Date.current - 1.day ], :order => 'date ASC, attending DESC')
    
    @showMatches = []
    @allShows.each do |show|
      match = show.bands.band_name_like(searchQuery.upcase).first
      if(match != nil) then
        @showMatches << show
      end
    end
    
    @bandMatches = Band.band_name_like(searchQuery.upcase)
    @bandMatches = @bandMatches.sort_by { |band| band.shows.length }
    @bandMatches = @bandMatches.reverse
    
    @venueMatches = @location.venues.name_like(searchQuery.upcase)
    @venueMatches = @venueMatches.sort_by { |venue| venue.shows.length }
    @venueMatches = @venueMatches.reverse
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
