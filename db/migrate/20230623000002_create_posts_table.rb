class CreatePostsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: :users, name: 'fk_posts_author_id' }
      t.string :title
      t.text :text
      t.timestamps
      t.integer :comments_counter
      t.integer :likes_counter
    end
  end
end
