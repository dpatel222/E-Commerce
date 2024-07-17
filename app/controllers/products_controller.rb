class ProductsController < ApplicationController
  # before_action :initialize_session

  def index
    @products = Product.all
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    if params[:filter].present?
      case params[:filter]
      when 'on_sale'
        @products = @products.where(on_sale: true)
      when 'recently_updated'
        @products = @products.recently_updated
      end
    end
    @products = @products.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?

    @products = @products.page(params[:page]).per(10)

    return unless @products.empty?

    flash.now[:alert] = 'No products match your search criteria.'
  end

  def show
    @product = Product.find(params[:id])
  end

  #   def add_to_cart
  #     id = params[:id].to_i
  #     session[:cart] << id unless session[:cart].include?(id)
  #     redirect_to root_path
  #   end
  #
  #   private
  #
  #   def initialize_session
  #     session[:cart] ||= []
  #   end
  def add_to_cart
    product_id = params[:id].to_i
    product = Product.find(product_id)

    if current_user
      # Find or create a cart item for the current user
      cart_item = current_user.cart_items.find_or_initialize_by(product:)
      cart_item.quantity = cart_item.quantity.to_i + 1
      cart_item.save
    else
      add_product_to_cart(product_id)
    end

    flash[:notice] = 'Product has been added to your cart.'
    redirect_to products_path
  end

  private

  def add_product_to_cart(product_id)
    session[:cart] ||= []
    existing_item = session[:cart].find { |item| item['product_id'] == product_id }

    if existing_item
      existing_item['quantity'] += 1
    else
      session[:cart] << { 'product_id' => product_id, 'quantity' => 1 }
    end
  end
end
