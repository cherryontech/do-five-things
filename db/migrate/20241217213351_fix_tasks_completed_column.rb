class FixTasksCompletedColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :complete, :completed
  end
end
