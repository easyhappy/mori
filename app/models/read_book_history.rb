class ReadBookHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :current_chapter,class_name: 'Chapter',foreign_key: 'current_chapter_id'

  
  class<<self
    def histories config
      self.where(user_id: config[:user_id], user_status: config[:user_status]).includes(:book,:current_chapter).order(updated_at: :desc).page(@page)
    end

    def set_current_chapter_history params
      history = ReadBookHistory.find_by_user_id_and_user_status_and_book_id(params[:user_id], params[:user_status], params[:book_id])
      unless history
        history = ReadBookHistory.new(:book_id => params[:book_id],
          :user_id => params[:user_id],
          :user_status => params[:user_status],
          )
      end
      history.current_chapter_id = params[:id]
      history.save
    end
  end

  def action_buttons
    I18n.t("main.action_buttons")
  end
end
