class CreateDailyProgs < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_progs do |t|
      t.references    :goal, null: false, foreign_key: true
      t.date          :date

      t.timestamps
    end

    add_index :daily_progs, %i[goal_id date], unique: true
  end
end
