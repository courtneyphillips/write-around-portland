class AddAmountToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :amount, :float
  end
end
