class Sessions::LoginPageController < ApplicationController
  def index
    render inertia: 'LoginPage', props: { prop: 'random' }
  end
end
