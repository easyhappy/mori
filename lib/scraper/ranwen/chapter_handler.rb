$:.unshift(File.dirname(__FILE__))

require 'chapters/init_handler'
require 'chapters/associate_handler'

module Scraper
  module Ranwen
    module ChapterHandler
      include Chapters::InitHandler
      include Chapters::AssociateHandler
    end
  end
end