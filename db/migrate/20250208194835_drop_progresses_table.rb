class DropProgressesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :progresses
  end
end
