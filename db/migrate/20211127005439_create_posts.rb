class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :scene
      t.text :comment
      t.text :image
      t.string :title
      t.string :author
      t.string :publisher_name
      t.integer :user_id
      t.text :book_image
      t.string :genre_id
      t.string :genre
      t.string :magazine

      t.timestamps
    end
  end
end
