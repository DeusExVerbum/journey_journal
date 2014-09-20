class RenameJourneyAttribBodyToDescription < ActiveRecord::Migration
  def change
    rename_column :journeys, :body, :description
  end
end
