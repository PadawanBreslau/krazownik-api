class AddEventToRiddlesAndTeams < ActiveRecord::Migration[6.0]
  def change
    add_reference :riddles, :event
    add_reference :teams, :event
  end
end
