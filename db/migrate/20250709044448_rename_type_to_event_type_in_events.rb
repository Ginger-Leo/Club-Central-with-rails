# frozen_string_literal: true

class RenameTypeToEventTypeInEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :type, :event_type
  end
end
