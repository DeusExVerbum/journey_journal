class AddStateToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :state, :string
  end
end
