$:.unshift(File.dirname(__FILE__))

module Contents
  module InitHandler
    attr_accessor :hydra
    attr_accessor :per_page
    attr_accessor :current_page

    def init_parse_content
      parse_conent_in_batch Chapter.where(:scraper_status => :open).paginate(:per_page => 50, :page => current_page) 
    end

    def parse_conent_in_batch chapters
      return unless chapters.present?
      hydra = Typhoeus::Hydra.new(max_concurrency: 10)
      chapters.each do |chapter|
        begin
          hydra.queue parse_content(chapter)
        rescue Exception => e
          logger_write e.inspect
        end
      end
      hydra.run
      puts '下一页了......'
      parse_conent_in_batch Chapter.where(:scraper_status => :open).paginate(:per_page => 50, :page => current_page)
    end

    def parse_content chapter
      request = Typhoeus::Request.new(chapter.url, :proxy => random_proxy, :timeout => 3000)
      request.on_complete do |response|
        puts chapter.url
        puts response.code
        if response.code == 200
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
            binding.pry
            logger_write e.inspect
          end
        end
        #sleep 1.seconds
      end
      request
    end

    def get_urls chapter, body, *positions
      base_url = chapter.url.rpartition('/')[0]
      begin
        positions.map do |position|
          get_url body, '#thumb', position
        end
      rescue
        positions.map do |position|
          get_url body, '.link_14', position
        end
      end
    end

    def get_url body, selector, position
      url = body.at_css(selector).children[position].attributes["href"].value
      url == 'index.html' ? '' : [base_url, url].join('/')
    end
  end
end