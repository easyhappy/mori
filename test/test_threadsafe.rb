require 'net/http'

uri = URI('http://localhost:8888/books')

20.times {
  5.times.map {
    Thread.new { Net::HTTP.get_response(uri) }
  }.each(&:join)
}
