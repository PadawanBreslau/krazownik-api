class AddCompletedAtToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :completed_at, :datetime
  end
end
