class AddReferenceToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :user, index: true
  end
end
