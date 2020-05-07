class MenuController < ApplicationController
  def index
    @cart_item = CartItem.where(user_id: current_user.id)
    @menu = Menu.active_menu
  end

  def create
    new_menu = Menu.create!(menu_name: params[:menu_name])
    redirect_to "/menu/new"
  end

  def new
  end

  def show
    render plain: "k"
  end
end
