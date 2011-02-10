xml.instruct! :xml, :version => "1.0"
xml.opml :version => "1.0" do
  xml.head do
    xml.title @title
  end
  xml.body do
    @contexts.each do |context|
      @languages.each do |language|
      xml.outline do
        xml.title "#{language} - #{context}"
        xml.text "#{language} - #{context}"
        xml.type "rss"
        xml.version "RSS"
        xml.xmlUrl "http://github-trends.oscardelben.com/languages/#{language}/#{context}.xml"
        xml.htmlUrl "http://github-trends.oscardelben.com/"
      end
    end
  end
end