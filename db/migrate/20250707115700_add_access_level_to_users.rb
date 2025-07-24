class AddAccessLevelToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :access_level, :string, default: 'player', null: false
    add_index :users, :access_level
  end
end
