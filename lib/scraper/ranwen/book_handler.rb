$:.unshift(File.dirname(__FILE__))

require 'books/init_handler'

module Scraper
  module Ranwen
    module BookHandler
      extend ActiveSupport::Concern
      include Books::InitHandler
    end
  end
end