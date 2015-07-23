class CreateOrdersPublications < ActiveRecord::Migration
  def change
    create_table :orders_publications do |t|
      t.integer :order_id
      t.integer :publication_id

      t.timestamps
    end
  end
end
