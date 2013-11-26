$:.unshift(File.dirname(__FILE__))

require 'book/init_handler'

module Scraper
  module Ranwen
    module BookHandler
      extend ActiveSupport::Concern
      include Book::InitHandler
    end
  end
end