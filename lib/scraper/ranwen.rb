#encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'mori'
require 'ranwen/book_handler'
require 'ranwen/chapter_handler'
require 'ranwen/content_handler'
require 'proxy'

class Ranwen
  include Mori
  include Scraper::Ranwen::BookHandler
  include Scraper::Ranwen::ChapterHandler
  include Scraper::Ranwen::ContentHandler
  include Scraper::Ranwen::ProxyHandler
end