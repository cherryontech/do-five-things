class ProgressPageController < ApplicationController
  def index
    render inertia: 'ProgressPage', props: { progs: Goal.last.daily_progs, startdate: Goal.last.start_date }
  end
end
