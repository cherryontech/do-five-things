class TaskService
  def self.fetch_today_tasks
    goal = Goal.last
    goal.tasks.decorate.map(&:as_json_for_today)
  end
end
