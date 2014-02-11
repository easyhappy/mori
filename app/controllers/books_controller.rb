class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  before_filter :set_access_control_headers, only: [:api]

  def index
    @books = Book.search params.merge(page: @page)
  end

  def show
    @chapters = @book.chapters
  end

  def search
    @books = Book.search params.merge(page: @page)
    render :index
  end

  def api
    puts 'aaaa'
    render :json => [{ "category" => "animals",  "type" => "haha" }]
  end

  private
  def set_book
    @book = Book.where(id: params[:id]).includes(:category).first
    @category_id = @book.category_id
  end

  def book_params
    params.require(:book).permit(:name, :code, :author, :last_updated_at, :source_id, :view_count, :desc, :recommend, :word_count, :comment_count, :deleted_at, :deleted)
  end

  def set_access_control_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE OPTIONS}.join(",")
    headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    head(:ok) if request.request_method == "OPTIONS"
  end
end
