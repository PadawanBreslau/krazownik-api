class AddSponsorToRiddles < ActiveRecord::Migration[6.0]
  def change
    add_column :riddles, :sponsor, :string
  end
end
