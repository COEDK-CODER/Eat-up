class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu_item
  def self.update(id, action)
    cart_item = CartItem.find(id)
    if action
      cart_item.item_quantity += 1
      cart_item.save!
    else
      cart_item.item_quantity -= 1
      cart_item.save!
      if cart_item.item_quantity == 0
        CartItem.find(id).destroy
      end
    end
  end

  def self.cart_id(item_id)
    cart_item = all.find_by(menu_item_id: item_id)
    if cart_item
      cart_item.id
    end
  end

  def self.quantity(item_id)
    cart_item = all.find_by(menu_item_id: item_id)
    if cart_item
      cart_item.item_quantity
    end
  end

  def self.of_user(user)
    all.where(user_id: user.id)
  end
end
