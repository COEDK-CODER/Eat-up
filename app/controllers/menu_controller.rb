class MenuController < ApplicationController
  def index
    @cart_item = CartItem.where(user_id: current_user.id)
    @menu = Menu.active_menu
  end

  def create
    new_menu = Menu.new(menu_name: params[:menu_name])
    if new_menu.save
      flash[:notice] = "#{params[:menu_name]} successfully created"
      redirect_to "/menu/new"
    else
      flash[:error] = new_menu.errors.full_messages.join(",")
      redirect_to new_menu_path
    end
  end

  def new
  end

  def show
  end

  def dash
  end
end
