# frozen_string_literal: true

class AddBalanceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :balance, :decimal, precision: 10, scale: 2, default: -100.00, null: false

    reversible do |dir|
      dir.up do
        User.where(access_level: 'admin').update_all(balance: 300.00)
      end
    end
  end
end
