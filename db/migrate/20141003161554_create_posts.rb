class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :content
      t.integer :sub_id, null: false
      t.string :author_id, null: false

      t.timestamps
    end

    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end
