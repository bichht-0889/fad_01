class AddNewCategoryToSugest < ActiveRecord::Migration[5.2]
  def change
    add_column :sugests, :new_category, :string
  end
end
