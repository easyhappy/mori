$:.unshift(File.dirname(__FILE__))

module Books
  module InitHandler
    attr_accessor :current_page

    def init_parse_book
      logger_write 'begin parse book...'
      
      begin
        pre_books_count = Book.count
        current_page = 444
        parse_books_list current_page
      rescue Exception => e
        logger_error e.inspect
      end

      books_count = Book.count
      logger_write("before is #{pre_books_count}, now is #{books_count}")
      logger_write("current_page is #{current_page}")
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
      parse_next_page doc
    end

    def parse_next_page doc
      pagelink = doc/"#pagelink"
      next_page = pagelink/"a.next"
      return if next_page.nil? || next_page.empty? || next_page.first.nil?
      
      relative_url, text = la next_page
      
      logger_write("抓取#{relative_url}...")
      current_page = $1 and parse_books_list(current_page) if relative_url =~ /page=(\d+)$/
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
        book.scraper_status = :open
        book.save!
        return
      end

      if book.last_chapter.try(:url) == last_chapter_url
        book.scraper_status   = :close
      else
        book.last_chapter_url = last_chapter_url
        book.scraper_status   = :open
      end
      book.save!
    end
  end
end