class ProgressPageController < ApplicationController
  def index
    render inertia: 'ProgressPage', props: { progs: Goal.last.daily_progs }
  end
end
