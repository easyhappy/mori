$:.unshift(File.dirname(__FILE__))

module Contents
  module InitHandler
    attr_accessor :hydra

    def init_parse_content
      #chapters = Chapter.where(:scraper_status => :open)
      chapters = Chapter.where(:id => 38009)
      hydra = Typhoeus::Hydra.new(max_concurrency: 10)
      chapters.each do |chapter|
        begin
          hydra.queue parse_content(chapter)
        rescue Exception => e
          logger_write e.inspect
        end
      end
      hydra.run
    end

    def parse_content chapter
      request = Typhoeus::Request.new(chapter.url, :proxy => random_proxy)
      request.on_complete do |response|
        return unless response.code == 200
        begin
          body = Nokogiri::HTML(response.body, nil, get_encoding)
          html = body.at_css("#content").inner_html
          pre_url, next_url = get_urls(chapter, body, 0, 2)
          Content.create! content: html, book_id: chapter.book_id,
                            chapter_id: chapter.id, word_count: content_count(html),
                            pre_url: pre_url, next_url: next_url
          chapter.scraper_status = :close
          chapter.save
        rescue Exception => e
          logger_write e.inspect
        end
        sleep 2.seconds
      end
      request
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