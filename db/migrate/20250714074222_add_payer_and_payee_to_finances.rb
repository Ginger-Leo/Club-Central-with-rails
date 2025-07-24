# frozen_string_literal: true

class AddPayerAndPayeeToFinances < ActiveRecord::Migration[8.0]
  def change
    add_reference :finances, :payer, null: true, foreign_key: { to_table: :users }
    add_reference :finances, :payee, null: true, foreign_key: { to_table: :users }
  end
end
