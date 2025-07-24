# frozen_string_literal: true

class RemoveNameAndTeamRoleFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :team_role, :integer
    remove_column :users, :access_level, :string
  end
end
