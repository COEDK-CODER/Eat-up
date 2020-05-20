class AddUrlToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :url, :string
  end
end
