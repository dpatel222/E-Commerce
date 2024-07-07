class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable

  belongs_to :province
  has_many :cart_items
  has_many :products, through: :cart_items
  has_many :orders
  has_many :ordered_items
end
