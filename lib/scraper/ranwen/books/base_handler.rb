module Books
  module BaseHandler
    extend ActiveSupport::Concern
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