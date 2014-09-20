class AddJourneyIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :journey_id, :integer
  end
end
