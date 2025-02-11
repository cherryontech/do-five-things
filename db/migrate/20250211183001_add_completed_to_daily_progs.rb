class AddCompletedToDailyProgs < ActiveRecord::Migration[7.1]
  def change
    change_table :daily_progs do |t|
      t.column :completed,    :boolean
      t.column :completed_at, :datetime
    end
  end
end
