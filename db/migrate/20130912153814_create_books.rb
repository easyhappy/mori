class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references  :category,        index: true
      t.references  :source,          index: true
      t.references  :last_chapter,    index: true

      t.string      :url
      t.string      :chapter_url
      t.string      :last_chapter_url

      t.string      :name
      t.string      :author
      
      t.string      :code
      t.string      :status
      t.string      :scrapter_status
      
      t.boolean     :recommend,       default: false
      t.boolean     :hot,             default: false
      t.boolean     :deleted,         default: false
      
      t.integer     :view_count,      default: 0
      t.integer     :comment_count,   default: 0
      t.integer     :word_count,      default: 0
      
      t.string      :desc

      t.string      :last_updated_at
      t.timestamp   :deleted_at
      t.timestamps
    end
  end
end
