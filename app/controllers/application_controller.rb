class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers # <-- This!

  before_action :require_user
  helper_method :current_user

  inertia_share auth: lambda {
    { user: current_user && { email: current_user.email, id: current_user.id } }
  }, flash: lambda {
    { notice: flash.notice, alert: flash.alert }
  }

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user
    return if current_user

    save_passwordless_redirect_location!(User) # <-- optional, see below
    redirect_to users_sign_in_path, inertia: { props: { random_prop: 'prop' } }
  end
end
