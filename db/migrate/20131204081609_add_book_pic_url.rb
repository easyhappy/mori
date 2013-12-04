class AddBookPicUrl < ActiveRecord::Migration
  def change
    add_column :books, :pic_url,  :string
  end
end
