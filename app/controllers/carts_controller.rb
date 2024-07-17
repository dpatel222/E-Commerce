class CartsController < ApplicationController
  def show
    @cart_items = if current_user
                    current_user.cart_items.includes(:product).map do |cart_item|
                      { product: cart_item.product, quantity: cart_item.quantity }
                    end
                  else
                    session[:cart]&.map do |item|
                      product = Product.find_by(id: item['product_id'])
                      { product:, quantity: item['quantity'] } if product && item['quantity'].present?
                    end&.compact || []
                  end
  end
end
