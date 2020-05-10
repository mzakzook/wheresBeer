class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brewery, null: false, foreign_key: true
      t.integer :rating
      t.string :favorite

      t.timestamps
    end
  end
end
