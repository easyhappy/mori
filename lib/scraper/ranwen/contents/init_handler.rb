$:.unshift(File.dirname(__FILE__))

module Contents
  module InitHandler

    def init_parse_content
      #chapters = Chapter.where(:scraper_status => :open)
      chapters = Chapter.where(:id => 38009)
      chapters.each do |chapter|
        begin
          parse_content(chapter)
          chapter.scraper_status = :close
          chapter.save
        rescue Exception => e
          binding.pry
          logger_write e.inspect
        end
      end
    end

    def parse_content chapter, try_count=3
      request = Typhoeus::Request.new(chapter.url, :proxy => 'http://59.39.145.178:3128')
      Typhoeus::Hydra.hydra.queue request
      Typhoeus::Hydra.hydra.run

      response = request.response
      binding.pry
      return unless response.code == 200
      body = Nokogiri::HTML(response.body, nil, get_encoding)
      html = body.at_css("#content").inner_html
      pre_url, next_url = get_urls(chapter, body, 0, 2)
      binding.pry
      Content.create! content: html, book_id: chapter.book_id,
                        chapter_id: chapter.id, word_count: content_count(html),
                        pre_url: pre_url, next_url: next_url
    end

    def get_urls chapter, body, *positions
      base_url = chapter.url.rpartition('/')[0]
      positions.map do |position|
        url = body.at_css("#thumb").children[position].attributes["href"].value
        url == 'index.html' ? '' : [base_url, url].join('/')
      end
    end
  end
end