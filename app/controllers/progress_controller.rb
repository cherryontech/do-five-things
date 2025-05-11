class ProgressController < AuthenticatedController
  def index
    daily_progs = @current_goal.daily_progs
    start_date = @current_goal.start_date
    render inertia: 'ProgressPage', props: { progs: daily_progs, startdate: start_date }
  end
end
