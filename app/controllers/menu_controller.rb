class MenuController < ApplicationController
  def index
    @cart_item = CartItem.where(user_id: current_user.id)
    @menu = Menu.active_menu
  end

  def create
    new_menu = Menu.new(menu_name: params[:menu_name])
    if new_menu.save
      flash[:notice] = "#{params[:menu_name]} Added Successfully"
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

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    menu = Menu.find(params[:id])
    menu.menu_name = params[:menu_name]
    if menu.save
      menu.save!
      redirect_to "/menu"
    else
      flash[:error] = menu.errors.full_messages.join(",")
      redirect_to edit_menu_path(id: params[:id])
    end
  end
end
