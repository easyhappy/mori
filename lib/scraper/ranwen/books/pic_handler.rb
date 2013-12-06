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
      request = Typhoeus::Request.new(book.url)
      Typhoeus::Hydra.hydra.queue request
      Typhoeus::Hydra.hydra.run

      response = request.response
      return unless response.code == 200
      body = Nokogiri::HTML(response.body, nil, get_encoding)
      pic_url = body.at_css(".picborder")["src"]
      book.pic_url = pic_url
      book.save
    end
  end
end