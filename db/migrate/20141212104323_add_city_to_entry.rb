class AddCityToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :city, :string
  end
end
