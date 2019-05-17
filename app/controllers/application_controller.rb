class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_timezone, if: :user_signed_in?



  def set_locale
    I18n.locale = extract_locale_from_user ||
                  params[:locale] ||
                  extract_locale_from_subdomain ||
                  extract_locale_from_tld || I18n.default_locale
  end

  def extract_locale_from_user
    current_user.language if current_user
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:language, :timezone])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:language, :timezone])
  end

  def set_timezone
    unless current_user.timezone.empty?
      Time.zone = current_user.timezone
    end
  end

end
