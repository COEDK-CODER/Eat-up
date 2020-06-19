class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def self.delivered
    all.where(order_status: "Delivered").order(id: :desc)
  end
  def self.not_delivered
    all.where(order_status: "Not Delivered").order(id: :desc)
  end
  def self.valid_date(fdate, edate)
    Date.parse(fdate) == Date.new or Date.parse(edate) == Date.new
  end
  def self.of_user(user)
    all.where(user_id: user.id)
  end
  def self.today_payment
    orders = all.where("order_date = ? and order_status = ?", Date.today, "Delivered")
    Order.amount(orders)
  end
  def self.amount(orders)
    amount = 0
    orders.each do |order|
      amount += order.amount
    end
    amount
  end
end
