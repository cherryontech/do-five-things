class FixTaskTable < ActiveRecord::Migration[7.1]
  def change
    goal = Goal.last.presence || Goal.create(start_date: Date.current)
    Task.where(goal_id: nil).update_all(goal_id: goal.id)
    change_column_null :tasks, :goal_id, false
  end
end
