class Menu < ActiveRecord::Base
  has_many :menu_items
  validates :menu_name, presence: true

  def self.active_menu
    menus = Array.new
    Menu.all.order(:id).each do |menu|
      if menu.menu_items.count > 0
        menus.push(menu)
      end
    end
    menus
  end
end
