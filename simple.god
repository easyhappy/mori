God.watch do |w|
  w.name = "simple"
  w.start = "rake scraper:content"
  w.keepalive
end
