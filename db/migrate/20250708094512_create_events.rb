class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.datetime :datetime, null: false
      t.string :type, null: false
      t.string :location
      t.text :notes

      t.timestamps
    end

    add_index :events, :datetime
    add_index :events, :type
  end
end
