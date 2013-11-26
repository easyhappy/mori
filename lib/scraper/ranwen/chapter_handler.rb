$:.unshift(File.dirname(__FILE__))

require 'chapters/init_handler'

module Scraper
  module Ranwen
    module ChapterHandler
      extend ActiveSupport::Concern
      include Chapters::InitHandler
    end
  end
end