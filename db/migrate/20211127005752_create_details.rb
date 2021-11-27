class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :genre_id
      t.string :genre
      t.string :magazine

      t.timestamps
    end
  end
end
