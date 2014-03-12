require 'grape-swagger'
class API < Grape::API
  get '/' do
    puts 'hello grapea aa'
  end
end