class AddDefaultToTotal < ActiveRecord::Migration
  def change
    remove_column :orders, :total
    add_column :orders, :total, :float, default: 0
  end
end
