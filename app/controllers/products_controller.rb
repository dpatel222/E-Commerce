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

    @products = @products.page(params[:page]).per(7)

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
  #
  
end
