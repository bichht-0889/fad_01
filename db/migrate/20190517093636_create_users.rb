class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.integer :role, default: 0
      t.string :remember_token
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :picture

      t.timestamps
    end
  end
end
