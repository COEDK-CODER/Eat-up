class MenuController < ApplicationController
  def index
    @cart_item = CartItem.of_user(current_user)
    @menu = Menu.active_menu
  end

  def create
    ensure_owner_logged_in
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
    ensure_owner_logged_in
  end

  def edit
    ensure_owner_logged_in
    @menu = Menu.find(params[:id])
  end

  def dash
    ensure_admin_logged_in
  end

  def update
    ensure_owner_logged_in
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

  def destroy
    ensure_owner_logged_in
    menu = Menu.find(params[:id])
    if menu.menu_items.count > 1
      flash[:error] = "Current Menu is n't empty"
      redirect_to "/menu/#{params[:id]}/edit"
    else
      menu.destroy
      redirect_to "/menu"
    end
  end
end
