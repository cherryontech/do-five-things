class ChangeTasksTable < ActiveRecord::Migration[7.1]
  def up
    change_table :tasks do |t|
      t.remove          :completed, :completed_at
      t.references      :goal, null: true, foreign_key: true
    end

    Task.where(goal_id: nil).update_all(goal_id: 1)
    change_column_null :tasks, goal_id: false
  end

  def down
    change_table :tasks do |t|
      t.remove_references :goal
      t.boolean :completed
      t.datetime :completed_at
    end
  end
end
