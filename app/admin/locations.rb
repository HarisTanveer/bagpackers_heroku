ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :description, :name
  #
  # or
  #
  #
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :images, :as => :file, multple: "true"
      f.input :description
      f.input :name
    end
    f.actions
  end
  permit_params do
    permitted = [:description, :name, :images]
    permitted << :other if params[:action] == 'create' && current_admin_user
    permitted
  end
  
end
