class AddStatusToSugests < ActiveRecord::Migration[5.2]
  def change
    add_column :sugests, :status, :int
  end
end
