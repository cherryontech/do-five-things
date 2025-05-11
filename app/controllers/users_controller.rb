class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(create_passwordless_session(@user)) # <-- This!
      redirect_to(@user, flash: { notice: 'Welcome!' })
    else
      render(:new)
    end
  end
end
