class SessionsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(resource)
    '/admin'
  end
end