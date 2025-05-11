class AuthenticatedController < ApplicationController
  include GoalScoped
  before_action :require_user!
end
