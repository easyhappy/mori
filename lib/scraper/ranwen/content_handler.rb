$:.unshift(File.dirname(__FILE__))

require 'contents/init_handler'
require 'contents/check_handler'

module Scraper
  module Ranwen
    module ContentHandler
      include Contents::InitHandler
      include Contents::CheckHandler
    end
  end
end