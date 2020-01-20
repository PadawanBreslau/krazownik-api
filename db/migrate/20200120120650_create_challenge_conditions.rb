class CreateChallengeConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :challenge_conditions do |t|
      t.references :challenge, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
