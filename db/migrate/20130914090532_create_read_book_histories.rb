class CreateReadBookHistories < ActiveRecord::Migration
  def change
    create_table :read_book_histories do |t|
      t.integer    :user_id, index: true
      t.integer    :user_status
      t.references :book, index: true
      t.integer    :current_chapter_id

      t.timestamps
    end

    add_index :read_book_histories, [:user_id, :user_status, :book_id], :name => :index_user_and_user_status, :unique => true
  end
end
