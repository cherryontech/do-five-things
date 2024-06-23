class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses do |t|

      t.timestamps
    end
  end
end
