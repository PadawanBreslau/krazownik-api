class DropTableNotes < ActiveRecord::Migration[6.0]
  def up
    drop_table :notes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
