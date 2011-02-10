xml.instruct! :xml, :version => "1.0"
xml.opml :version => "1.0" do
  xml.head do
    xml.title "#{@language} - All Feeds"
  end
  xml.body do
    @contexts.each do |context|
      xml.outline :title => "#{@language} - #{context}", :text => "#{@language} - #{context}", :type => "rss", :version => "RSS", :xmlUrl => "http://github-trends.oscardelben.com/languages/#{@language}/#{context}.xml", :htmlUrl => "http://github-trends.oscardelben.com/"
    end
  end
end