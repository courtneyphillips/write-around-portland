class AddEmailAndCartTokenToOrders < ActiveRecord::Migration
  def change
    add_column(:orders, :email, :string)
    add_column(:orders, :card_token, :string)
    add_column(:orders, :address, :string)
  end
end
