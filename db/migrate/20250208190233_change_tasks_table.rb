class ChangeTasksTable < ActiveRecord::Migration[7.1]
  def up
    change_table :tasks do |t|
      t.remove          :completed, :completed_at
      t.references      :goal, null: true, foreign_key: true
    end
  end

  def down
    change_table :tasks do |t|
      t.remove_references :goal
      t.boolean :completed
      t.datetime :completed_at
    end
  end
end
