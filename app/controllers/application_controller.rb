class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :configure_devise_params, if: :devise_controller?
  
  # def configure_devise_params
  #   devise_parameter_sanitizer.for(:sign_up) do |u|
  #     u.permit(:name, :email, :password, :password_confirmation)
  #   end
  # end

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    wikis_path
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation, :stripe_card_token]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end
