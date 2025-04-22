class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers # <-- This!
  before_action :initialize_progs

  helper_method :current_user

  private

  def initialize_progs
    today = Date.current.to_s
    return if session[:initialize_progs] == today

    ProgService.initialize_progs
    session[:initialize_progs] = today
  end

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if Rails.env.development?
    return if current_user

    save_passwordless_redirect_location!(User) # <-- optional, see below
    redirect_to login_path, inertia: { props: { random_prop: 'prop' } }
  end
end
