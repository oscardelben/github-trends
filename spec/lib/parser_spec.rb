require 'spec_helper'

describe Parser do

  context "Languages" do
  
    let(:url) { "https://github.com/languages/Ruby" }
    
    before(:each) do
      file = File.read(File.join(File.dirname(__FILE__), '..', 'mocks/ruby.html'))

      FakeWeb.register_uri(:get, url, :body => file)
    end

    describe "#most_watched_today" do

      it "should return todays' most watched repos" do
        expected = [['amatsuda', 'kaminari'], 
          ['evanphx', 'prattle'], 
          ['sferik', 'rails_admin'],
          ['dmathieu', 'cylon'],
          ['joshuaclayton', 'blueprint-css']]

        Parser.new(url).most_watched_today.should == expected
      end
    end

    describe "#most_watched_this_week" do

      it "should return this week's most watched repos" do
        expected = [['amatsuda', 'kaminari'],
          ['evanphx', 'prattle'],
          ['sferik', 'rails_admin'],
          ['dmathieu', 'cylon'],
          ['joshuaclayton', 'blueprint-css']]

        Parser.new(url).most_watched_this_week.should == expected
      end

    end

    describe "#most_watched_this_month" do

      it "should return this month's most watched repos" do
        expected = [['rails', 'rails'],
          ['diaspora', 'diaspora'],
          ['mxcl', 'homebrew'],
          ['seejohnrun', 'easy_translate'],
          ['vinibaggio', 'outpost']]

        Parser.new(url).most_watched_this_month.should == expected
      end

    end

    describe "#most_watched_overall" do

      it "should return overall's most watched repos" do
        expected = [['rails', 'rails'],
          ['diaspora', 'diaspora'],
          ['mxcl', 'homebrew'],
          ['joshuaclayton', 'blueprint-css'],
          ['binarylogic', 'authlogic']]

        Parser.new(url).most_watched_overall.should == expected
      end

    end

    describe "#most_forked_today" do

      it "should return today's most forked repos" do
        expected = [['sferik', 'rails_admin'],
          ['intridea', 'omniauth'],
          ['hassox', 'dm-polymorphic'],
          ['aarongough', 'deepopenstruct'],
          ['goncalossilva', 'permalink_fu']]

        Parser.new(url).most_forked_today.should == expected
      end

    end

    describe "#most_forked_this_week" do

      it "should return this week's most forked repos" do
        expected = [['sferik', 'rails_admin'],
          ['intridea', 'omniauth'],
          ['hassox', 'dm-polymorphic'],
          ['aarongough', 'deepopenstruct'],
          ['goncalossilva', 'permalink_fu']]

        Parser.new(url).most_forked_this_week.should == expected
      end

    end

    describe "#most_forked_this_month" do

      it "should return this month's most forked repos" do
        expected = [['mxcl', 'homebrew'],
          ['diaspora', 'diaspora'],
          ['rails', 'rails'],
          ['mongoid', 'mongoid'],
          ['collectiveidea', 'delayed_job']]

        Parser.new(url).most_forked_this_month.should == expected
      end

    end

    describe "#most_forked_overall" do

      it "should return overall's most forked repos" do
        expected = [['mxcl', 'homebrew'],
          ['rails', 'rails'],
          ['diaspora', 'diaspora'],
          ['thoughtbot', 'paperclip'],
          ['Shopify', 'active_merchant']]

        Parser.new(url).most_forked_overall.should == expected
      end

    end

  end

  context "All languages" do
    
    let(:url) { 'https://github.com/explore' }

    before(:each) do
      file = File.read(File.join(File.dirname(__FILE__), '..', 'mocks/explore.html'))

      FakeWeb.register_uri(:get, url, :body => file)
    end
    
    it "should return a list of repos" do
      expected = [['mrdoob', 'three.js'],
        ['mozilla', 'narcissus'],
        ['twinbit', 'Drupal-APT-Xapian'],
        ['redsand', 'bl4ckJack'],
        ['jgv', 'is-the-L-train-fucked']]

      Parser.new(url).trending_repos.should == expected
    end

  end

end
