class Order < ActiveRecord::Base
  has_many :publication_purchases
  has_many :publications, through: :publication_purchases

  def update_total
    self.total = publication_purchases.map {|purchase|
      purchase.publication.price*purchase.quantity}.reduce(:+)
  end

  def quantity(publication)
    publication_purchases.where(publication_id: publication.id).limit(1).first.quantity
  end

  def add_items(params)
    # params is a hash of key value pairs 'publication_id => quantity'
    params.each do |publication_id, quantity|
      publications << Publication.find(publication_id)
      purchase = publication_purchases.find { |purchase|
          purchase.publication_id == publication_id.to_i }
      purchase.quantity = quantity
    end
  end

  def process_payment
    customer = Stripe::Customer.create  email: email,
                                        card: card_token

    Stripe::Charge.create  customer: customer.id,
                            amount: self.total.to_i * 100,
                            currency: 'usd',
                            receipt_email: customer.email
  end

end
