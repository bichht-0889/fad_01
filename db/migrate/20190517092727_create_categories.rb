class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :status, default: 1
      t.string :name

      t.timestamps
    end
  end
end
