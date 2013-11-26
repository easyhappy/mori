$:.unshift(File.dirname(__FILE__))
require 'base_handler'

module Book
  module InitHandler
    extend ActiveSupport::Concern
    include Book::BaseHandler

    def init_parse
      logger_write 'begin parse book...'
      
      url = "#{BASE_URL}/modules/article/index.php?page=#{page}"
      doc = h url,ENCODING
      parse_books_info doc
    end

    def parse_books_info doc
      (doc/"table.sf-grid/tbody/tr").each do |tr|
        begin
          parse_book_info_part tr
        rescue Exception => e
          logger_error e.inspect
        end
      end
    end

    def parse_book_info_part tr
      td = tr/"td"
      category, name, last_chapter, author, chapter_url, status = td

      category_name = $1 if (t category) =~ /\[(.*?)\]/
      book_url, book_name = la name/"a"
      last_chapter_url, last_chapter_name = la last_chapter/"a"
    
      category = Category.find_or_create_by_name category_name
      book = Book.find_by_url book_url
      config = {
         name: book_name, url: book_url,category_id: category.id, 
         author: author,status: status, chapter_url: chapter_url,
         last_chapter_url: last_chapter_url, last_updated_at: Time.now
        }

      if book.nil?
        book = Book.new config
        book.scrapter_status = :open
        book.save
        return
      end
    end
  end
end