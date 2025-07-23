class MoveGoalsToUsers < ActiveRecord::Migration[7.1]
  def up
    Goal.destroy_all

    add_reference :goals, :user, null: false, foreign_key: true
  end

  def down
    remove_reference :goals, :user
  end
end
