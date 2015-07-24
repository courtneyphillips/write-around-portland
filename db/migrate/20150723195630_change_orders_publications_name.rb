class ChangeOrdersPublicationsName < ActiveRecord::Migration
  def change
    drop_table :orders_publications
    create_table :publication_purchases do |t|
      t.integer :order_id
      t.integer :publication_id
      t.integer :quantity

      t.timestamps
    end
  end
end
