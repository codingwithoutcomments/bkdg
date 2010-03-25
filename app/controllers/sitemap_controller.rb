class SitemapController < ApplicationController
  def sitemap
      @shows = Show.find(:all, :order => "updated_at DESC", :limit => 50000)
      headers["Content-Type"] = "text/xml"
      # set last modified header to the date of the latest entry.
      headers["Last-Modified"] = @shows[0].updated_at.httpdate
          
  end
  
end
