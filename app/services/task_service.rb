class TaskService
  def self.fetch_today_tasks(user)
    goal = user.current_goal
    goal.tasks.decorate.map(&:as_json_for_today)
  end
end
