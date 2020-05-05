class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item
  def self.active_order_items(id, order_no)
    @cart_item = CartItem.where(user_id: id)
    @cart_item.all.each do |cart_item|
      OrderItem.create!(order_id: order_no, menu_item_id: cart_item.menu_item_id,
                        menu_item_name: cart_item.cart_item,
                        menu_item_price: cart_item.cart_item_price,
                        quantity: cart_item.item_quantity)
    end
    @cart_item.destroy_all
  end
end
