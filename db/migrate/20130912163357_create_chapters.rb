class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references    :book,          index: true
      t.references    :volume,        index: true
      
      t.string        :url,           index: true
      t.string        :chapters_url
      t.string        :name
      
      t.integer       :parent_id
      t.integer       :next_id
      
      t.string        :code,          index: true
      t.string        :deleted
      
      t.integer       :view_count,    :integer

      t.timestamp     :deleted_at
      t.timestamps
    end
  end
end
