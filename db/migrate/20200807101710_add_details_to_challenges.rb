class AddDetailsToChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :details, :jsonb
  end
end
