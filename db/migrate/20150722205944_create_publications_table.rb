class CreatePublicationsTable < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :author_id
      t.float :price, :default => 12
      t.integer :release_year

      t.timestamps
    end
  end
end
