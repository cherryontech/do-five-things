class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.integer     :order
      t.text        :text
      t.boolean     :completed
      t.datetime    :completed_at

      t.timestamps
    end
  end
end
