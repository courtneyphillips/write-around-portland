class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :card_token

      t.timestamps
    end
  end
end
