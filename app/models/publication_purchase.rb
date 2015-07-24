class PublicationPurchase < ActiveRecord::Base
  belongs_to :order
  belongs_to :publication
end
