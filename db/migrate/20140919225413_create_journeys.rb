class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
