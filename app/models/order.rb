class Order < ActiveRecord::Base
  has_and_belongs_to_many :publications

  def calculate_total
    sum = 0
    publications.map(&:price).each {|price| sum += price}
    self.total = sum
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
