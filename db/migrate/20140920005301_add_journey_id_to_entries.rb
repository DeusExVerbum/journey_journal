class AddJourneyIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :journey_id, :integer
    add_index :entries, :journey_id
  end
end
