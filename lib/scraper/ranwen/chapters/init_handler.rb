$:.unshift(File.dirname(__FILE__))
require 'base_handler'

module Chapters
  module InitHandler
    extend ActiveSupport::Concern

    def init_parse_chapter
      books = Book.where(:scrapter_status => :open)

      books.each do |book|
        parse_chapter
      end
    end
    
    def parse_chapter book
      doc = h book.chapter_url, ENCODING
      book_info = doc/"#container_bookinfo"
    
      parent_id = nil
      (book_info/"tr/td/div.dccss/a").each do |a|
        begin
          relative_url, chapter_name = la a

          url = book.chapter_url.sub('index.html',relative_url)
          config = {book_id: book.id, name: chapter_name,url: url, parent_id: parent_id}
          chapter = Chapter.find_by_url url
          log "\t#{chapter_name}"

          chapter = Chapter.create config if chapter.nil?
          parent_id = chapter.id
        rescue Exception => e
          logger_write e.inspect
          break
        end
      end
      book.last_chapter_id = Chapter.find_by_id(parent_id).id
      book.scrapter_status = :close if book.last_chapter_url == Chapter.find_by_id(parent_id).url 
      book.save
    end
  end
end