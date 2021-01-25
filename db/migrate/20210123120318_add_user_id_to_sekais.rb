class AddUserIdToSekais < ActiveRecord::Migration[5.2]
  def change
    add_column :sekais, :user_id, :integer
  end
end
