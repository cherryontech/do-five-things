class UsersController < ApplicationController
  skip_before_action :require_user, only: %i[new create]

  def new
    if current_user
      redirect_to root_path
    else
      render inertia: 'SignUpPage', props: { username: '', email: '', errors: {} }
    end
  end

  def create
    @user = User.new(resource_params)

    if @user.save
      # pwless_session = build_passwordless_session(@user)
      # pwless_session.save!
      # Passwordless::Mailer.sign_in(pwless_session, pwless_session.token).deliver_later
      # redirect_to users_sign_in_path(token: pwless_session.token)
      sign_in(create_passwordless_session(@user)) # <-- This!
      redirect_to root_path, notice: "Welcome!"
    else
      render(
        inertia: 'SignUpPage',
        props: { username: @user.username, email: @user.email, errors: @user.errors.to_hash },
        status: :unprocessable_entity
      )
    end
  end

  def resource_params
    params.require(:user).permit(:username, :email)
  end
end
