class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

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
end
