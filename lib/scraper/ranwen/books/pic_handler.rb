$:.unshift(File.dirname(__FILE__))

module Books
  module PicHandler
    def parse_book_pics
      books = Book.where("pic_url is null")
      before_count = books.count
      
      books.each do |book|
        begin
          parse_book_pic book
        rescue Exception => e
          logger_write e.inspect
        end
      end
    end

    def parse_book_pic book
      doc = h book.url,get_encoding
      binding.pry
    end
  end
end