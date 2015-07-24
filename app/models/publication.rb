class Publication < ActiveRecord::Base
  belongs_to :author, :foreign_key => "author_id", :class_name => "User"
  has_many :publication_purchases
  has_many :orders, through: :publication_purchases
  scope :price, ->(id) { find(id).price }
end
