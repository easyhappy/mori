class AddBookUpdatedIndex < ActiveRecord::Migration
  def change
    add_index :books, :updated_at, :name => :index_book_updated_at
  end
end
