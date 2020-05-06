class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.date :order_date
      t.integer :amount
      t.string :order_type
      t.string :order_status
      t.timestamps
    end
  end
end
