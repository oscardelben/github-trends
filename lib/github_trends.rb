require 'rubygems'

require 'bundler'
Bundler.setup

require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'builder'
require 'sinatra/cache'

$:.unshift File.dirname(__FILE__)

require 'parser'

disable :run
set :root, File.dirname(__FILE__) + '/../'
set :cache_enabled, true # production

LANGUAGES = ['ActionScript', 'Ada', 'Arc', 'Asp', 'Assembly', 'Boo', 'C', 'C#', 'C++', 'Clojure', 'CoffeeScript', 'ColdFusion', 'Common Lisp', 'D', 'Delphi', 'Dubi', 'Eiffel', 'Emacs Lisp', 'Erlang', 'F#', 'Factor', 'FORTRAN', 'Go', 'Groovy', 'Haskell', 'HaXe', 'Io', 'Java', 'JavaScript', 'Lua', 'Max/MSP', 'Nu', 'Objective-C', 'Objective-J', 'OCaml', 'ooc', 'Perl', 'PHP', 'Pure Data', 'Python', 'R', 'Racket', 'Ruby', 'Scala', 'Scheme', 'sclang', 'Self', 'Shell', 'SmallTalk', 'SuperCollider', 'Tcl', 'Vala', 'Verilog', 'VHDL', 'VimL', 'Visual Basic', 'XQuery']

CONTEXTS = ['most_watched_today', 'most_watched_this_week', 'most_watched_this_month', 'most_watched_overall', 'most_forked_today', 'most_forked_this_week', 'most_forked_this_month', 'most_forked_overall']

get "/" do
  settings.environment.to_s
end

get "/languages/:language/:context.xml" do
  if !LANGUAGES.include?(params['language']) || !CONTEXTS.include?(params['context'])
    return 404
  end

  url = "https://github.com/languages/#{params['language']}"
  @repos = Parser.new(url).send(params['context'])

  @title = "#{params['language']} #{params['context'].gsub('_', ' ').capitalize}"

  builder :show
end
