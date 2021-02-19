class CreateCryptoRiddleSolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_riddle_solutions do |t|
      t.references :crypto_challenge, null: false, foreign_key: true
      t.references :crypto_participation, null: false, foreign_key: true
      t.string :answer
      t.integer :good_answer_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
