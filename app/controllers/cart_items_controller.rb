class CartItemsController < ApplicationController
  def create
    new_cart_item = CartItem.create!(user_id: current_user.id,
                                     menu_item_id: params[:menu_item_id],
                                     cart_item: params[:menu_item],
                                     cart_item_price: params[:price],
                                     item_quantity: 1)

    redirect_to "/menu"
  end

  def index
    @cart_item = CartItem.where(user_id: current_user.id)
  end

  def update
    CartItem.update(params[:id], params[:state])
    if params[:from] == "cart"
      redirect_to "/cart_items"
    else
      redirect_to "/menu"
    end
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def clear
    CartItem.where(user_id: current_user.id).destroy_all
    redirect_to cart_items_path
  end
end
