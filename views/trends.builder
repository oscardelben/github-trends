xml.instruct! :xml, :version => "1.0"
xml.opml :version => "1.0" do
  xml.head do
    xml.title "Github Trends"
  end
  xml.body do
    @contexts.each do |context|
      @languages.each do |language|
        xml.outline :title => "#{language} - #{context.gsub('_', ' ').capitalize}", :text => "#{language} - #{context.gsub('_', ' ').capitalize}", :type => "rss", :version => "RSS", :xmlUrl => "http://github-trends.oscardelben.com/languages/#{language}/#{context}.xml", :htmlUrl => "http://github-trends.oscardelben.com/"
      end
    end
  end
end