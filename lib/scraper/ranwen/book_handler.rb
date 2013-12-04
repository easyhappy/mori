$:.unshift(File.dirname(__FILE__))

require 'books/init_handler'
require 'books/pic_handler'

module Scraper
  module Ranwen
    module BookHandler
      include Books::InitHandler
      include Books::PicHandler
    end
  end
end