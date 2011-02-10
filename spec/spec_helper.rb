
require File.join(File.dirname(__FILE__), '..', 'lib', 'github_trends.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'fake_web'

include Rack::Test::Methods

set :environment, :test

def app
  @app ||= Sinatra::Application
end

FakeWeb.allow_net_connect = false
