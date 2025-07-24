class CreateFinances < ActiveRecord::Migration[8.0]
  def change
    create_table :finances do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :notes
      t.string :transaction_type, null: false

      t.timestamps
    end

    add_index :finances, :transaction_type
    add_index :finances, :created_at
  end
end
