module Book
  module BaseHandler
    extend ActiveSupport::Concern

    def logger_write message
      Rails.logger.info message
    end

    def logger_error message
      Rails.logger.fatal '-'*60
      Rails.logger.fatal message
      Rails.logger.fatal '-'*60
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