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

  def update
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    if current_user
      cart_item = current_user.cart_items.find_by(product_id:)
      cart_item.update(quantity:) if cart_item
    else
      session[:cart].each do |item|
        item['quantity'] = quantity if item['product_id'] == product_id
      end
    end

    flash[:notice] = 'Cart updated successfully.'
    redirect_to cart_path
  end

  def destroy
    product_id = params[:product_id].to_i

    if current_user
      current_user.cart_items.find_by(product_id:)&.destroy
    else
      session[:cart].delete_if { |item| item['product_id'] == product_id }
    end

    flash[:notice] = 'Item removed from cart.'
    redirect_to cart_path
  end
end
