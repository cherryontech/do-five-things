class AddTaskProgs < ActiveRecord::Migration[7.1]
  def change
    create_table :task_progs do |t|
      t.references        :daily_prog, null: false, foreign_key: true
      t.references        :task, null: false, foreign_key: true
      t.boolean           :completed
      t.datetime          :completed_at

      t.timestamps
    end

    add_index :task_progs, %i[daily_prog_id task_id], unique: true
  end
end
