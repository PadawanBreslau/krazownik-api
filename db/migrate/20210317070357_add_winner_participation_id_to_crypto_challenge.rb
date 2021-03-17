class AddWinnerParticipationIdToCryptoChallenge < ActiveRecord::Migration[6.0]
  def change
    add_column :crypto_challenges, :winner_participation_id, :integer
  end
end
