class MenuItem < ActiveRecord::Base
  belongs_to :menu
  validates :menu_item, presence: true
  validates :price, presence: true
  def self.menu_items(id)
    MenuItem.where(menu_id: id)
  end

  def self.active_menus
    menus = Array.new
    Menu.all.each do |menu|
      if menu.id != no
        menus.push(menu)
      end
    end
    menus
  end
end
