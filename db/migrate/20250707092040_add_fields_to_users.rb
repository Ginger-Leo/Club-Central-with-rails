class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :email, :string, null: false
    add_column :users, :password_digest, :string
    add_column :users, :team_role, :integer, default: 0

    # Add indexes for performance and uniqueness
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :team_role
  end
end
