$:.unshift(File.dirname(__FILE__))

require 'contents/init_handler'

module Scraper
  module Ranwen
    module ContentHandler
      include Contents::InitHandler
    end
  end
end