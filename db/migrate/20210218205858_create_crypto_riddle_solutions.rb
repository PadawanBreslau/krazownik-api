class CreateCryptoRiddleSolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_riddle_solutions do |t|
      t.references :crypto_riddle, null: false, foreign_key: true
      t.references :crypto_participation, null: false, foreign_key: true
      t.string :answer
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
