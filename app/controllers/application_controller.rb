class ApplicationController < ActionController::Base
  before_action :initialize_progs

  private

  def initialize_progs
    today = Date.current.to_s
    return if session[:initialize_progs] == today

    ProgService.initialize_progs
    session[:initialize_progs] = today
  end
end
