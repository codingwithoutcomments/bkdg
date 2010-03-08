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
    
    @band = Band.find(params[:id])
    
     if(!@band.has_pictures?)
        retrieve_pictures(@band) 
      end
      
      if(@band.info == nil)
        retrieve_band_info(@band)
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
    @band = Band.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
  # GET /bands/1/edit
  def editSummary
    @band = Band.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
  # GET /bands/1/pictures
  def pictures
    
    @page   = params[:page]
    @band   = Band.find(params[:id])
    @totalPictures = @band.bandpictures.count
    
    @bandPictures = @band.bandpictures.paginate :per_page => 12, :page => params[:page]
    
    respond_to do |format|
      format.html # pictures.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
  # get /bands/1/picture/1
  def picture
    
    @pictureNumber = params[:page]
    @band = Band.find(params[:id])
    @totalPictures = @band.bandpictures.count
    
    @bandPictures = @band.bandpictures.paginate :per_page => 1, :page => params[:page]
    
    respond_to do |format|
      format.html # pictures.html.erb
      format.xml  { render :xml => @venue }
    end
  end
  
  def update
    @band = Band.find(params[:id])
    respond_to do |format|
      if @band.update_attributes(params[:band])
        flash[:notice] = "#{capitalize_first_letter_of_each_word(@band.band_name)} Profile was successfully updated."
        format.html { redirect_to(:action =>'show', :id => @band) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
      end
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
         picture.extralarge = sizes.at("size[@name='extralarge']").inner_html
         picture.save
         headliner.add_picture_to_band(picture)
       end

     rescue OpenURI::HTTPError
       logger.error("Unable to get pictures for #{headliner.band_name} from last.fm")

 end
 
 def retrieve_band_info(band)
   band_sans_spaces = band.get_XML_ready_string()
   last_fm_get_info_string = "http://ws.audioscrobbler.com/2.0/?method=artist.getInfo&artist=" + band_sans_spaces + "&api_key=7a8a93a66b33946440ad048191c80609"
   xml_retrieved = open(last_fm_get_info_string)
   doc = Hpricot.XML(xml_retrieved)
       (doc/:bio).each do |bio|
         temp = bio.at("summary").inner_html
         temp = temp.sub(/<!\[CDATA\[/, "")
         temp = temp.sub(/\]\]>/, "")
         temp = temp.gsub(/<\/?a[^>]*>/, "")
         band.info = temp
         band.save
       end

     rescue OpenURI::HTTPError
       logger.error("Unable to get pictures for #{band.band_name} from last.fm")

 end
  
end