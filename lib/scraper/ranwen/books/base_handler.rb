module Books
  module BaseHandler
    extend ActiveSupport::Concern
    BOOK_LOGGER = Logger.new(STDOUT)

    def logger_write message
      BOOK_LOGGER.info message
    end

    def logger_error message
      BOOK_LOGGER.logger.fatal '-'*60
      BOOK_LOGGER.logger.fatal message
      BOOK_LOGGER.logger.fatal '-'*60
    end

    def get_base_url
      "http://www.ranwen.net"
    end

    def pre_page
      25
    end

    def get_encoding
      "gb2312"
    end
  end
end