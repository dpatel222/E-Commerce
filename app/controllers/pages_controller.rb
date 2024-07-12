class PagesController < ApplicationController
  def home
    @categories = Category.all
    @selected_category_id = params[:category_id]
    @selected_category = Category.find_by(id: @selected_category_id) if @selected_category_id.present?

    @products = if @selected_category
                  @selected_category.products
                else
                  Product.all # Fetch all products if no category is selected
                end
  end

  def redirect
    redirect_to root_path(category_id: params[:category_id])
  end
end
