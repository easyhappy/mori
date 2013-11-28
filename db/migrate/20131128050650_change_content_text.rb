class ChangeContentText < ActiveRecord::Migration
  def change
    change_column :contents, :content, :longtext
  end
end
