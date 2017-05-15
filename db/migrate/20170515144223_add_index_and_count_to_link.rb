class AddIndexAndCountToLink < ActiveRecord::Migration[5.0]
  def change
    add_index :links, :name
    add_column :links, :count, :decimal, :default => 0
  end
end
