class Order < ActiveRecord::Base
  has_many :publication_purchases
  has_many :publications, through: :publication_purchases

  def calculate_total
    publication_purchases.each do |purchase|
      self.total += purchase.publication.price*purchase.quantity
    end
  end

  def quantity(publication)
    publication_purchases.where(publication_id: publication.id).limit(1).first.quantity
  end

  def add_items(params)
    # params is a hash of key value pairs 'publication_id => quantity'
    params.keys.each do |publication_id|
      publication_purchases.new(publication_id: publication_id,
                                quantity: params[publication_id])
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
