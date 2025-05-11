class ProgService
  def self.initialize_progs
    goal = current_user.current_goal
    DailyProg.create_or_find_by!(goal: goal, date: Date.current)
  end
end
