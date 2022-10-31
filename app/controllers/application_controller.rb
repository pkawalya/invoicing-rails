class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :config_devise_params, if: :devise_controller?
  #around_action :switch_locale
  after_action :store_action

  private

  def member_controller?
    return false if controller_path == "home"

    true
  end

  def layout_by_resource
    case
    when devise_controller? && resource_name == :user && (action_name == "new" || action_name == "create" || action_name == "password")
      "session"
    else
      "application"
    end
  end

  protected

  def after_sign_in_path_for(resource_or_scope)
    "/dashboard"
    #stored_location_for(resource_or_scope) || super
  end

  def after_sign_out_path_for(resource_or_scope)
    "/"
  end

  def store_action
    return unless request.get?
    if (
         request.path != "/users/sign_in" && request.path != "/users/sign_up" &&
           request.path != "/users/password/new" &&
           request.path != "/users/password/edit" &&
           request.path != "/users/confirmation" &&
           request.path != "/users/sign_out" && !request.xhr?
       ) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

  def config_devise_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        first_name
        last_name
        email
        password
        password_confirmation
        user_profile_attributes
      ]
    )
  end

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env["HTTP_ACCEPT_LANGUAGE"]}"
    locale =
      current_user.try(:locale) || params[:locale] ||
        extract_locale_from_accept_language_header || I18n.default_locale
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  private

  def extract_locale_from_accept_language_header
    request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
  end
end
