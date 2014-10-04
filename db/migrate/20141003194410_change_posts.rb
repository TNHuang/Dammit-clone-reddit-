class ChangePosts < ActiveRecord::Migration
  def change
    remove_column :posts, :author_id
    add_column :posts, :author_id, :integer
    change_column :posts, :author_id, :integer, null: false

    add_index :posts, :author_id
  end
end
