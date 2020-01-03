class AddPointsToChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :points, :integer
  end
end
