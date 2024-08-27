class TodayPageController < ApplicationController
  def index
    render inertia: "TodayPage"
  end
end
