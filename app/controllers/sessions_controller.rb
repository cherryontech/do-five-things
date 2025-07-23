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

  def create
    @user = User.new(email: params[:email])

    if @user.save
      sign_in(create_passwordless_session(@user)) # <-- This!
      redirect_to root_path, intertia: { props: { message: 'Welcome!' } }
    else
      redirect_to login_path, inertia: {
        props: {
          message: 'nah!',
          errors: @user.errors,
          user: @user
        }
      }, status: :unprocessable_entity
    end
  end

  private

  def require_unauth!
    return unless current_user

    redirect_to('/', notice: 'You are already signed in.')
  end
end
