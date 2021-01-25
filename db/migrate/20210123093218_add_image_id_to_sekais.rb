class AddImageIdToSekais < ActiveRecord::Migration[5.2]
  def change
    add_column :sekais, :image_id, :string
  end
end
