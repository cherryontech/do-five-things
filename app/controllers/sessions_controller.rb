class SessionsController < ApplicationController
  def index
    render inertia: 'LoginPage'
  end
end
