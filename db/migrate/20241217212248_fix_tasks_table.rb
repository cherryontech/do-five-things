class FixTasksTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :name, :text
    add_column    :tasks, :completed_at, :datetime
  end
end
