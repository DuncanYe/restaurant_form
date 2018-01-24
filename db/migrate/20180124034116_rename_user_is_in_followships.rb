class RenameUserIsInFollowships < ActiveRecord::Migration[5.1]
  def change
    rename_column :followships, :user_is, :user_id
  end
end
