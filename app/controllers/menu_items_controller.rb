class MenuItemsController < ApplicationController
  before_action :ensure_owner_logged_in

  def new
  end

  def create
    new_menu_item = MenuItem.new(menu_item: params[:menu_item], description: nil,
                                 price: params[:price],
                                 menu_id: params[:menu_id])
    if new_menu_item.save
      flash[:notice] = "#{params[:menu_item]} Added Successfully"
    else
      flash[:error] = new_menu_item.errors.full_messages.join(",")
    end
    redirect_to new_menu_path
  end

  def show
    @menu_item = MenuItem.find(params[:id])
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    menu_item = MenuItem.find(params[:id])
    menu_item.menu_item = params[:menu_item]
    menu_item.menu_id = params[:menu_id]
    menu_item.price = params[:price]
    if menu_item.save
      menu_item.save!
      redirect_to "/menu"
    else
      flash[:error] = menu_item.errors.full_messages.join(",")
      redirect_to edit_menu_item_path(id: params[:id])
    end
  end

  def destroy
    menu_item = MenuItem.find(params[:id])
    menu_id = menu_item.menu_id
    menu_item.destroy
    redirect_to "/menu##{Menu.find(menu_id).menu_name}"
  end
end
