class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :set_time_zone, if: :user_signed_in?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name username avatar])
  end

  # def set_time_zone
  #   Time.zone = current_user.time_zone
  # end
end
