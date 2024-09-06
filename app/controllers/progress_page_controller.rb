class ProgressPageController < ApplicationController
  def index
    render inertia: "ProgressPage"
  end
end
