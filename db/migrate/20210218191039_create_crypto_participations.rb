class CreateCryptoParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :crypto_participations do |t|
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
