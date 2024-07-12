class CategoriesController < ApplicationController
  def select
    # This action will render the form page
    @categories = Category.all
  end

  def redirect
    # This action will handle the form submission
    redirect_to category_path(params[:category_id])
  end
end
