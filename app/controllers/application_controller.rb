class ApplicationController < ActionController::Base
  protect_from_forgery

  #layout :layout_by_resource

  protected

  #def layout_by_resource
    #if devise_controller?
    #  "admin"
    #else
    #  "application"
    #end
  #end

  def after_sign_in_path_for(resource)
    # @user = User.find(resource.id)
    # user_path(@user)
    rails_admin_path
  end

end
