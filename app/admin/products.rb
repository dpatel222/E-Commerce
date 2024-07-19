ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :stock_quantity, :on_sale, :category_id, :image
  filter :has_one_attached
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock_quantity, :on_sale, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #
  form do |f|
    f.inputs          # builds an input field for every attribute
    f.input :image, as: :file
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
