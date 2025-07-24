class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :position, :string
    add_column :users, :chain, :string
    add_column :users, :car, :boolean, default: false, null: false
    add_column :users, :location, :string
  end
end
