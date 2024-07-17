class OrdersController < ApplicationController
  def index
    @user = current_user
    @orders = @user.orders.includes(ordered_items: :product).order(created_at: :desc)
  end
end
