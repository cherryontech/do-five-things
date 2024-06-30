class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.integer :order
      t.text    :name
      t.boolean :complete

      t.timestamps
    end
  end
end
