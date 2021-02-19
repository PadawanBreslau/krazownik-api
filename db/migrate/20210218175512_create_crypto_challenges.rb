class CreateCryptoChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_challenges do |t|
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
