class Api::BooksController < Api::BaseController
  def index
    render :json => {models: Book.all.limit(5)}
  end
end