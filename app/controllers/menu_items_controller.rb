class MenuItemsController < ApplicationController
  def new
  end

  def create
    new_menu_item = params[:menu_item]
    price = params[:price]
    menu_id = params[:menu_id]
    MenuItem.create!(menu_item: new_menu_item, description: nil, price: price, menu_id: menu_id)
    redirect_to "/menu/new"
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
    menu_item.save!
    redirect_to "/menu"
  end

  def destroy
    MenuItem.find(params[:id]).destroy
    redirect_to "/"
  end
end
