class ProductsController < ApplicationController
  def index
    @products = if params[:category_id].present?
                  Product.where(category_id: params[:category_id])
                else
                  Product.all
                end
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
  end
end
