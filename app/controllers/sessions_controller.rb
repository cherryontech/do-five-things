class SessionsController < Passwordless::SessionsController
  before_action :require_unauth!, only: %i[new show]

  def index
    render inertia: 'LoginPage', props: { prop: 'random' }
  end

  def new
    render inertia: 'LoginPage', props: { prop: 'random' }
  end

  def show
    render inertia: 'LoginPage', props: { prop: 'random' }
  end

  def create; end

  private

  def require_unauth!
    return unless current_user

    redirect_to('/', notice: 'You are already signed in.')
  end
end
