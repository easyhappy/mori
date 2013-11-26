$:.unshift(File.dirname(__FILE__))
require 'base_handler'

module Books
  module InitHandler
    extend ActiveSupport::Concern
    include Books::BaseHandler

    def init_parse
      logger_write 'begin parse book...'

      parse_books_list
    end

    def parse_books_list page=1
      url = "#{get_base_url}/modules/article/index.php?page=#{page}"
      doc = h url,get_encoding
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
      #parse_next_page doc
    end

    def parse_next_page doc
      pagelink = doc/"#pagelink"
      next_page = pagelink/"a.next"
      logger_write("抓取完毕...") and return if next_page.nil? || next_page.empty? || next_page.first.nil?
      
      relative_url, text = la next_page
      
      logger_write("抓取#{relative_url}...")
      parse_books_list $1 if relative_url =~ /page=(\d+)$/
    end

    def parse_book_info_part tr
      td = tr/"td"
      category, name, last_chapter, author, chapter_url, status = td

      category_name = $1 if (t category) =~ /\[(.*?)\]/
      book_url, book_name = la name/"a"
      last_chapter_url, last_chapter_name = la last_chapter/"a"

      chapter_url = (la chapter_url/"a")[0]
      author      = (la author/"a")[1]
      status      = (la status/"font")[1]
    
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
        book.save!
        return
      end
    end
  end
end