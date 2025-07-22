class LoginPageController < ApplicationController
  def index
    render inertia: 'LoginPage'
  end
end
