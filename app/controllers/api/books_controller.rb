class Api::BooksController < Api::BaseController
  def index
    render :json => Book.all.limit(5).to_json
  end
end