class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :published_year
      t.string :isbn
      t.text :description
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
