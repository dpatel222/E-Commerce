class ProductsController < ApplicationController
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

    return unless @products.empty?

    flash.now[:alert] = 'No products match your search criteria.'
  end

  def show
    @product = Product.find(params[:id])
  end
end
