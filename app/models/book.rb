class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :last_chapter, :class_name => :Chapter

  has_many   :chapters, counter_cache: true

  scope :hot,   ->{where("view_count>1").includes(:category).order(view_count: :desc).limit(10)}
  scope :recent,->{includes(:category).order(updated_at: :desc).limit(10)}

  def self.search config
    @q = config[:q]
    sw = SearchWord.find_by q: @q
    if sw.nil?
      sw = SearchWord.create q: @q
    else
      sw.update_attributes count: (sw.count||0)+1
    end
    SearchLog.create search_word_id: sw.id,user_id: config[:user_id],q: @q
    self.where("name like ? or author like ?","%#{@q}%","%#{@q}%").page(config[:page]).order(view_count: :desc)
  end

  def read_button
    I18n.t("book.read_button")
  end
end
