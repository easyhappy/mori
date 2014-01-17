class ChaptersController < ApplicationController
  after_filter :add_history_log, only: :show

  def show
    @chapter = Chapter.find_by_id(params[:id])
  end

  private
  def add_history_log
    find_current_user
    ReadBookHistory.set_current_chapter_history params.merge!({book_id: @chapter.book_id})
  end
end
