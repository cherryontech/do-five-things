class TaskService
  def self.fetch_today_tasks
    goal = Goal.first.presence || Goal.create!(start_date: Date.current)
    daily_prog = DailyProg.find_or_initialize_by(goal: goal, date: Date.current)
    daily_prog.save! if daily_prog.new_record?
    goal.tasks.decorate.map(&:as_json_for_today)
  end
end
