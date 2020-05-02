class MenuController < ApplicationController
  def index
    @cart_item = CartItem.where(user_id: current_user.id)
  end

  def create
    new_menu = Menu.create!(menu_name: params[:menu_name])
    redirect_to "/menu/new"
  end
end
