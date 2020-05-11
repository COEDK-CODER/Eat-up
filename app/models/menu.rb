class Menu < ActiveRecord::Base
  has_many :menu_items
  validates :menu_name, presence: true

  def self.active_menu
    menus = Array.new
    Menu.all.order(:id).each do |menu|
      menus.push(menu)
    end

    @active_menus = Array.new
    for i in 0..menus.size - 1
      next if i.odd?
      menu = Array.new
      menu.push(menus[i])
      menu.push(menus[i + 1])
      @active_menus.push(menu)
    end
    @active_menus
  end
end
