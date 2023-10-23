class CreateCatImages < ActiveRecord::Migration[7.0]
  def change
    create_table :cat_images do |t|
      t.references :cat, null: false, foreign_key: true
      t.json :image

      t.timestamps
    end
  end
end
