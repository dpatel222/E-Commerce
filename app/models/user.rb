class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable

  belongs_to :province
  has_many :cart_items
  has_many :products, through: :cart_items
  has_many :orders
  has_many :ordered_items

  validates :address, presence: true

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items ordered_items orders products province]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[address created_at current_sign_in_at current_sign_in_ip email encrypted_password id
       id_value last_sign_in_at last_sign_in_ip name password province_id remember_created_at reset_password_sent_at reset_password_token sign_in_count updated_at]
  end
end
