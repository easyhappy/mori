#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__))

require 'scraper/ranwen'

namespace :scraper do
  desc "parse book"
  task :book => :environment do
    Ranwen.new.init_parse_book
  end
  
  desc "parse chapter"
  task :chapter => :environment do
    Ranwen.new.init_parse_chapter
  end
  
  desc "parse content"
  task :content => :environment do
    page = ENV['page']
    max_page = ENV['max_page']
    Ranwen.new.init_parse_content
  end
  
  desc "update book"
  task :update => :environment do
    Ranwen.new.parse_book_update
  end
  
  desc "parse special content"
  task :special => :environment do
    Ranwen.new.parse_special_book
  end
  
  desc "parse chapter associate"
  task :associate => :environment do
    Ranwen.new.parse_chapter_associate
  end

  desc "check chapter and content"
  task :check_content => :environment do
    Ranwen.new.check_contents
  end
end