class AddDateToTaskProgs < ActiveRecord::Migration[7.1]
  def change
    change_table :task_progs do |t|
      t.column :date, :date
    end
  end
end
