require 'will_paginate'

class BandsController < ApplicationController
  # GET /bands
  # GET /bands.xml
  def index
    @bands = Band.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  # GET /bands/1
  # GET /bands/1.xml
  def show
    showID = params[:id]
    @band = Band.find(:first, :conditions => ["id = ?", showID])
    
     if(!@band.has_pictures?)
        retrieve_pictures(@band) 
      end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /bands/new
  # GET /bands/new.xml
  def new
    @bands = Band.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /bands/1/edit
  def edit
    @bands = Band.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
  # GET /bands/1/pictures
  def pictures
    
    showID = params[:id]
    @band = Band.find(:first, :conditions => ["id = ?", showID])
    
    @bandPictures = @band.bandpictures.paginate :per_page => 12, :page => params[:page]
    
    respond_to do |format|
      format.html # pictures.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
private

def retrieve_pictures(headliner)
  headliner_sans_spaces = headliner.get_XML_ready_string()
  last_fm_get_picture_string = "http://ws.audioscrobbler.com/2.0/?method=artist.getimages&artist=" + headliner_sans_spaces + "&api_key=7a8a93a66b33946440ad048191c80609"
  xml_retrieved = open(last_fm_get_picture_string)
  doc = Hpricot.XML(xml_retrieved)
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
      
    rescue OpenURI::HTTPError
      logger.error("Unable to get pictures for #{headliner.band_name} from last.fm")
    
end
  
end