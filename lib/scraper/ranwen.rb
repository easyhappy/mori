#encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'mori'
require 'ranwen/book_handler'

class Ranwen
  include Mori
  include Scraper::Ranwen::BookHandler
end