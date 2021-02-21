class AddCryptoRiddleSolutionsCountToCryptoParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :crypto_participations, :crypto_riddle_solutions_count, :integer
  end
end
