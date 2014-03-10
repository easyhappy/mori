class MainController < ApplicationController
  after_filter :find_current_user
  def index
    @histories = ReadBookHistory.histories params.merge({page: @page})
    @hot_books = Book.hot
    @recent_books = Book.recent
    
  end
end