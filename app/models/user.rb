class User < ActiveRecord::Base
  has_secure_password
  has_many :cart_items
  has_many :orders
  validates :first_name, presence: true
  validates :email, presence: true
  def self.of_user(user)
    all.where(user_id: user.id)
  end
end
