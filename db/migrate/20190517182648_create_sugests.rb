class CreateSugests < ActiveRecord::Migration[5.2]
  def change
    create_table :sugests do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
