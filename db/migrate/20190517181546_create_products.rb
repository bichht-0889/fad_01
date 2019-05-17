class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.float :price
      t.integer :quantity
      t.string :description
      t.float :avg_rating, default: 0
      t.string :picture

      t.timestamps
    end
  end
end
