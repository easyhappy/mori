class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.string :content

      t.timestamps
    end
  end
end
