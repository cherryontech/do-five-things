class ChangeTasksTable < ActiveRecord::Migration[7.1]
  def change
    change_table :tasks do |t|
      t.remove          :completed, :completed_at
      t.references      :goal, null: false, foreign_key: true
    end
  end
end
