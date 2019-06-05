class AddContentToRates < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :content, :string
  end
end
