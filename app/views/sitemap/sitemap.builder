xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  
  i = 0
  @shows.each do |show|
    xml.url do
      begin
        xml.loc url_for(:controller => 'shows', 
                        :action => 'show', 
                        :id => show,
                        :only_path => false)
        xml.lastmod show.updated_at.to_date
      rescue
            xml.loc url_for(:controller => 'shows', 
                            :action => 'show', 
                            :id => show.id,
                            :only_path => false)
            xml.lastmod show.updated_at.to_date
      end
      i = i + 1
    end
    
    if( i > 600) then
      break
    end
  end
  
  @locations.each do |location|
    xml.url do
      xml.loc url_for(:controller => 'locations', 
                      :action => 'show', 
                      :id => location,
                      :only_path => false)
    end
  end
  
end