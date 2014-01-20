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
          logger_write e.inspect
        end
      end
    end

    def parse_content chapter, try_count=3
      request = Typhoeus::Request.new(chapter.url)
      Typhoeus::Hydra.hydra.queue request
      Typhoeus::Hydra.hydra.run

      response = request.response
      return unless response.code == 200
      body = Nokogiri::HTML(response.body, nil, get_encoding)
      html = body.at_css("#content").inner_html
      pre_url, next_url = get_urls(chapter, body, 0, 2)

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

    def parse_content_old chapter
      doc   = h chapter.url,get_encoding
      html  = (doc/"#content").inner_html
      begin
        html = html.sub """\r\n\r\n<div align=\"center\"><script src=\"/ssi/style-gg.js\" type=\"text/javascript\"></script></div> \r\n\t\t\t""",""
        html = html.sub "\r\n\t\t\t",''
      rescue Exception => e
        logger_write e.inspect
      end

      base_url = chapter.url.rpartition('/')[0]
      
      paginations = doc/'div#fenye/div#thumb/a'
      pre_url = (la (paginations.first))[0]
      next_url = (la (paginations[2]))[0]

      pre_url = pre_url == 'index.html'  ?   '' : [base_url, pre_url].join('/')
      next_url = next_url  == 'index.html' ? '' : [base_url, next_url].join('/')
      Content.create! content: html, book_id: chapter.book_id,
                        chapter_id: chapter.id, word_count: content_count(html),
                        pre_url: pre_url, next_url: next_url
      return chapter if chapter.name.present?

      title = t doc/"h1.bname_content"
      title = $1 if title =~ /《.*》\s*(.*?)/
      
      chapter.name = title
      chapter
    end
  end
end