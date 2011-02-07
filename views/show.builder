xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @title
    xml.description @title
    xml.link "http://github-trends.oscardelben.com"

    @repos.each do |repo|
      xml.item do
        xml.title "#{repo[0]} / #{repo[1]}"
        xml.link "http://github.com/#{repo[0]}/#{repo[1]}"
        xml.description 
        xml.pubDate
        xml.guid "http://github.com/#{repo[0]}/#{repo[1]}" 
      end
    end
  end
end

