class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  @counter = 0

  class << self
    attr_accessor :counter
  end

  #trap(:INFO) {
  #  $stderr.puts "Count: #{BooksController.counter}"
  #}

  def index
    counter = self.class.counter # read
    sleep(0.1)
    counter += 1                 # update
    sleep(0.1)
    self.class.counter = counter # write
    #puts "self.class.counter is #{self.class.counter}"
    render :json => {data: counter}
  end

  def index_old
    @books = Book.search params.merge(page: @page)
  end

  def show
    @chapters = @book.chapters
  end

  def search
    @books = Book.search params.merge(page: @page)
    render :index
  end

  private
  def set_book
    @book = Book.where(id: params[:id]).includes(:category).first
    @category_id = @book.category_id
  end

  def book_params
    params.require(:book).permit(:name, :code, :author, :last_updated_at, :source_id, :view_count, :desc, :recommend, :word_count, :comment_count, :deleted_at, :deleted)
  end
end
