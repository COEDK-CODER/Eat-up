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
end
