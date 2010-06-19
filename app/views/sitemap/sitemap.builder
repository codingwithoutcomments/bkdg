xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  
  #@shows.each do |show|
  #  xml.url do
  #    xml.loc url_for(:controller => 'shows', 
  #                    :action => 'show', 
  #                    :id => show,
  #                    :only_path => false)
  #    xml.lastmod show.updated_at.to_date
  #  end
  #end
  
  @locations.each do |location|
    xml.url do
      xml.loc url_for(:controller => 'locations', 
                      :action => 'show', 
                      :id => location,
                      :only_path => false)
    end
  end
  
end