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

  def order_items
    province = current_user.province
    cart_items = current_user ? current_user.cart_items : session[:cart]

    order = Order.create(user: current_user)

    cart_items.each do |cart_item|
      product = Product.find(cart_item['product_id'])
      total_tax_rate = (province&.HST.to_f + province&.PST.to_f + province&.GST.to_f).to_f
      item_price = product.price.to_f
      total_price = item_price * cart_item['quantity'].to_i * (1 + total_tax_rate / 100.0)

      OrderedItem.create(
        user: current_user,
        order:,
        product:,
        quantity: cart_item['quantity'].to_i,
        item_price:,
        total_price:
      )
    end

    current_user ? current_user.cart_items.destroy_all : session[:cart] = []
    flash[:notice] = 'Your order has been placed successfully.'
    redirect_to root_path
  end

  def confirm_order
    if current_user
      @cart_items = current_user.cart_items.includes(:product)
      @province = current_user.province

      @subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
      @taxes = calculate_taxes(@province, @subtotal)

      @total = @subtotal + @taxes[:hst] + @taxes[:pst] + @taxes[:gst]
    else
      redirect_to root_path, alert: 'You need to be logged in to view your cart.'
    end
  end

  private

  def calculate_taxes(province, subtotal)
    hst_rate = province.HST.to_f / 100.0
    pst_rate = province.PST.to_f / 100.0
    gst_rate = province.GST.to_f / 100.0

    hst = subtotal * hst_rate
    pst = subtotal * pst_rate
    gst = subtotal * gst_rate

    { hst:, pst:, gst: }
  end
end
