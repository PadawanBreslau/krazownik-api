class CreateCryptoRiddles < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_riddles do |t|
      t.references :crypto_challenge, null: false, foreign_key: true
      t.string :solution

      t.timestamps
    end
  end
end
