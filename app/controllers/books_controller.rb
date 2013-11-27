class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.search params.merge(page: @page)
  end

  def show
    @chapters = @book.chapters
    ClickLog.click params.merge({ref_obj: @book})
    @pre_chapter,@current_chapter,@next_chapter = ReadBookHistory.reading_chapters params.merge({ref_obj: @book})
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
