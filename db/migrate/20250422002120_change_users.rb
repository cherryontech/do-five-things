class ChangeUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, 'LOWER(email)', unique: true, name: 'index_users_on_lowercase_email' # <-- prevent duplicate emails
    change_column_null :users, :email, false
  end
end
