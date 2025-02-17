class AddDefaultGoalIdToTasks < ActiveRecord::Migration[7.1]
  def change
    Task.where(goal_id: nil).update_all(goal_id: 1)
  end
end
