class AddDetailsToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :complete, :boolean
    add_column :goals, :target, :integer, :default => 183
  end
end
