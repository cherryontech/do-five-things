module GoalScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_current_goal
    before_action :ensure_daily_prog
  end

  private

  def set_current_goal
    @current_goal = current_user.current_goal
  end

  def ensure_daily_prog
    today = Date.current.to_s
    return if session[:initialize_progs] == today

    DailyProg.create_or_find_by!(
      goal: @current_goal,
      date: Date.current
    )
    session[:initialize_progs] = today
  end
end
