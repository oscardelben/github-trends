require 'spec_helper'

describe "GithubTrends" do

  describe "/" do

    it "should be successful" do
      get "/"

      last_response.should be_ok
    end

  end

  describe "/languages/:language/:context.xml" do

    let(:url) { "https://github.com/languages/Ruby" }

    before(:each) do
      file = File.read(File.join(File.dirname(__FILE__), '..', 'mocks/ruby.html'))

      FakeWeb.register_uri(:get, url, :body => file)
    end

    context "invalid context" do

      it "should return 404 for invalid language" do
        get '/languages/Fake/most_watched_today.xml'

        last_response.status.should == 404
      end

      it "should return 404 for invalid context" do
        get '/languages/Ruby/foo.xml'

        last_response.status.should == 404
      end

    end

    context "most_watched_today" do

      it "should return the correct repos" do
        get '/languages/Ruby/most_watched_today.xml'

        last_response.should be_ok
        last_response.headers['Content-Type'].should == 'application/xml;charset=utf-8'

        %w!kaminari prattle rails_admin cylon blueprint-css!.each do |repo|
          last_response.body.should include(repo)
        end

        last_response.body.should include("Ruby Most watched today")   
      end

    end

  end


end
