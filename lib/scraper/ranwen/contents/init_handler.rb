$:.unshift(File.dirname(__FILE__))

module Contents
  module InitHandler
    attr_accessor :hydra
    attr_accessor :per_page
    attr_accessor :current_page
    attr_accessor :per_page

    def init_parse_content
      per_page = 20
      parse_conent_in_batch Chapter.where(:scraper_status => :open).paginate(:per_page => per_page, :page => current_page) 
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
      parse_conent_in_batch Chapter.where(:scraper_status => :open).paginate(:per_page => per_page, :page => current_page)
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
            logger_write e.inspect + chapter.url unless parse_content_by_hpricot chapter
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
          get_url body, '#thumb', position, base_url
        end
      rescue
        positions.map do |position|
          get_url body, '.link_14', position, base_url
        end
      end
    end

    def get_url body, selector, position, base_url
      url = body.at_css(selector).children[position].attributes["href"].value
      url == 'index.html' ? '' : [base_url, url].join('/')
    end

    private
    def parse_content_by_hpricot chapter
      begin
        doc = h chapter.url, get_encoding
        html  = (doc/"#content").inner_html
        begin
          html = html.sub """\r\n\r\n<div align=\"center\"><script src=\"/ssi/style-gg.js\" type=\"text/javascript\"></script></div> \r\n\t\t\t""",""
          html = html.sub "\r\n\t\t\t",''
        rescue Exception => e
          logger_write e.inspect + chapter.url
        end
        pre_url, next_url = get_url_by_hpricot chapter, doc
        Content.create! content: html, book_id: chapter.book_id,
                                chapter_id: chapter.id, word_count: content_count(html),
                                pre_url: pre_url, next_url: next_url
        chapter.scraper_status = :close
        return chapter.save
      rescue Exception => e
        logger_write e.inspect
        return false
      end
    end

    def get_url_by_hpricot chapter, doc
      base_url = chapter.url.rpartition('/')[0]
      begin 
        urls = (doc/"#thumb/a").map do |item|
          get_absolute_url(base_url, item['href'])
        end
        [urls[0], urls[2]]
      rescue Exception => e
        urls = (doc/"td.link_14/a").map do |item|
          get_absolute_url(base_url, item['href'])
        end
        [urls[0], urls[2]]
      end
    end

    def get_absolute_url(base_url, url)
      url == 'index.html' ? '' : [base_url, url].join('/')
    end
  end
end