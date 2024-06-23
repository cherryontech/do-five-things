class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.date    :timezone
      t.string  :username
      t.string  :email
      t.boolean :show_progress, default: false

      t.timestamps
    end
  end
end
