require 'rubygems'

require 'bundler'
Bundler.setup

require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'builder'
require 'sinatra/cache'
require 'uri'

$:.unshift File.dirname(__FILE__)

require 'parser'

disable :run
set :root, File.dirname(__FILE__) + '/../'
set :cache_enabled, true # production

LANGUAGES = ['ActionScript', 'Ada', 'Arc', 'Asp', 'Assembly', 'Boo', 'C', 'C#', 'C++', 'Clojure', 'CoffeeScript', 'ColdFusion', 'Common Lisp', 'D', 'Delphi', 'Dubi', 'Eiffel', 'Emacs Lisp', 'Erlang', 'F#', 'Factor', 'FORTRAN', 'Go', 'Groovy', 'Haskell', 'HaXe', 'Io', 'Java', 'JavaScript', 'Lua', 'Max/MSP', 'Nu', 'Objective-C', 'Objective-J', 'OCaml', 'ooc', 'Perl', 'PHP', 'Pure Data', 'Python', 'R', 'Racket', 'Ruby', 'Scala', 'Scheme', 'sclang', 'Self', 'Shell', 'SmallTalk', 'SuperCollider', 'Tcl', 'Vala', 'Verilog', 'VHDL', 'VimL', 'Visual Basic', 'XQuery']

CONTEXTS = ['most_watched_today', 'most_watched_this_week', 'most_watched_this_month', 'most_watched_overall', 'most_forked_today', 'most_forked_this_week', 'most_forked_this_month', 'most_forked_overall']

get "/" do
  @languages = LANGUAGES
  @contexts = CONTEXTS
  haml(:index)
end

get "/explore/:context.xml" do
  if !['today', 'week', 'month', 'forever'].include?(params['context'])
    return 404
  end

  url = "https://github.com/explore/#{params['context']}"
  @repos = Parser.new(url).trending_repos
  @title = "Trending Repos - #{params['context'].capitalize}"
  builder :show
end

get %r{\/languages\/(.+)\.opml} do |language|
  if !LANGUAGES.include?(language)
    return 404
  end

  @language = language
  @contexts = CONTEXTS

  builder :language
end

get "/languages/*/:context.xml" do
  language = params[:splat].first
  if !LANGUAGES.include?(language) || !CONTEXTS.include?(params['context'])
    return 404
  end

  # Can't use CGI.escape since it would convert ' ' to + instead of %20
  escaped = URI.escape(language, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

  url = "https://github.com/languages/#{escaped}"
  @repos = Parser.new(url).send(params['context']).map{ |repo| repo << Parser.fetch_description("https://github.com/#{repo[0]}/#{repo[1]}") }

  @title = "#{language} #{params['context'].gsub('_', ' ').capitalize}"

  builder :show
end

get "/trends.opml" do
  @languages = LANGUAGES
  @contexts = CONTEXTS

  builder :trends
end

