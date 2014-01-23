require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'timeout'
module Scraper
  module Ranwen
    module ProxyHandler
      #解密规则
      CHAR_TO_INT = {
        'a' => '2', 'c' => '1', 'r' => '8', 'i' => '7', 'q' => '0',
        'd' => '0', 'k' => '2', 'm' => '4', 'l' => '9',  'v' => '3',
        'b' => '5', 'w' => '6', 'z' => '3'
      }
    
      PROXY_LIST = []
      def analyze_proxys
        for page_no in 1..10 do                  #一共有10页
          url = "http://www.cnproxy.com/proxy#{page_no}.html"
          content = Net::HTTP.get(URI.parse(url))
          regex=/<td>(.*?)<SCRIPT type=text\/javascript>document.write\(":"(.*?)\)<\/SCRIPT><\/td>/   #http://www.rubular.com
          
          for array in content.scan(regex)
            line = array[0]+':'+char2int(array[1].delete('+'))
            check(line)
          end
        end

        output_to_file
      end

      def random_proxy
        load_proxy_list unless PROXY_LIST.present?
        proxy = PROXY_LIST.sample(1)[0]
        "http://#{proxy.join(':')}"
      end

      private
      def load_proxy_list
        File.open("data/proxy.dat") do |file|
          while line = file.gets
            server, port, cost = line.split(",")
            PROXY_LIST << [server, port]
          end
        end
      end
      
      def char2int(str)
        for i in 0.. str.length-1
          str[i] = CHAR_TO_INT[str[i]] if CHAR_TO_INT[str[i]].present?
        end
        return str
      end
    
      def check(ip)
        url='www.baidu.com';
        begin
          Timeout::timeout(5)  do |timeout_length|
            proxy_addr=ip.split(":")[0]; proxy_port=ip.split(":")[1].to_i
            proxy =Net::HTTP::Proxy(proxy_addr, proxy_port).start(url) do |http|
              start_at = Time.now
              response = http.get('/')
              end_at = Time.now
              
              cost = end_at - start_at
              PROXY_LIST << [proxy_addr, proxy_port, cost]
              puts "\e[32m#{ip.rstrip} accessing #{url} using #{cost.to_s}\e[30m\n"#观察各个代理服务器的响应时间各是多少
            end
          end
          return true
        rescue Exception => ex
          puts ex.message
          return false
        end
      end
    
      def output_to_file
        File.open("data/proxy.dat", 'w') do |file|
          PROXY_LIST.each do |proxy|
            file.write proxy.join(",") + '\\\\n'
          end
        end
      end
    end
  end
end