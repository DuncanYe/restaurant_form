class RenameRestauratInComments < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :restaurat_id, :restaurant_id
  end
end
