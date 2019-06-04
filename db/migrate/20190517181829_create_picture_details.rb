class CreatePictureDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :picture_details do |t|
      t.references :product, foreign_key: true
      t.string :picture_url

      t.timestamps
    end
  end
end
