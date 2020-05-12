class CartItemsController < ApplicationController
  def create
    new_cart_item = CartItem.create!(user_id: current_user.id,
                                     menu_item_id: params[:menu_item_id],
                                     cart_item: params[:menu_item],
                                     cart_item_price: params[:price],
                                     item_quantity: 1)
    menu_id = MenuItem.find(params[:menu_item_id]).menu_id

    redirect_to "/menu##{Menu.find(menu_id).menu_name}"
  end

  def index
    @cart_item = CartItem.of_user(current_user)
  end

  def update
    menu_item_id = CartItem.find(params[:id]).menu_item_id
    CartItem.update(params[:id], params[:state])

    if params[:from] == "cart"
      redirect_to "/cart_items"
    else
      menu_item = MenuItem.find(menu_item_id)
      redirect_to "/menu/##{Menu.find(menu_item.menu_id).menu_name}"
    end
  end

  def destroy
    CartItem.of_user(current_user).find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def clear
    CartItem.of_user(current_user).destroy_all
    redirect_to cart_items_path
  end
end
