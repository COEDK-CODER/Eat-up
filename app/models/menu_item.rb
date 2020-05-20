class MenuItem < ActiveRecord::Base
  belongs_to :menu
  validates :menu_item, presence: true
  validates :description, presence: true
  validates :url, presence: true
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
  def self.sales(orders, fdate, edate)
    if !(Order.valid_date(fdate, edate)) and orders.count > 0
      orderitems = OrderItem.where("order_id >= ? and order_id <= ?", orders.first.id, orders.last.id).group(:menu_item_name).order(:menu_item_name).sum(:quantity)
    else
      orderitems = nil
    end
  end
end
