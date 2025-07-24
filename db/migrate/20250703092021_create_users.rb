# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :access_level, null: false, default: 'user'

      t.timestamps
    end

    add_index :users, :access_level
  end
end
