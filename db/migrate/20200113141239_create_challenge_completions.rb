class CreateChallengeCompletions < ActiveRecord::Migration[6.0]
  def change
    create_table :challenge_completions do |t|
      t.references :participations
      t.references :challenges
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
