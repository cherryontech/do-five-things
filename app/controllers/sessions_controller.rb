class SessionsController < Passwordless::SessionsController
  skip_before_action :require_user

  def new
    render inertia: 'LoginPage', props: { prop: 'random' }
  end

  def show
    super
    # IMPORTANT: call super to let Passwordless validate token & sign in.
    render inertia: 'TokenPage'
  end

  private

  def redirect_path_after_failed_sign_in
    users_sign_in_path
  end
end
