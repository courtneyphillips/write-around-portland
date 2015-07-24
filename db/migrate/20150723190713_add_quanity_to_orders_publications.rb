class AddQuanityToOrdersPublications < ActiveRecord::Migration
  def change
    add_column :orders_publications, :quantity, :integer
  end
end
