class AddContentChapterUrl < ActiveRecord::Migration
  def change
    add_column :contents, :pre_url, :string
    add_column :contents, :next_url, :string
  end
end
