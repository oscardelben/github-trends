require 'fileutils'

namespace :cache do

  desc 'flush cache'
  task :flush do
    languages_path = File.dirname(__FILE__) + "/public/languages"
    FileUtils.remove_dir(languages_path) rescue nil
  end

end
