class Donation < ActiveRecord::Base


  def process_payment
    customer = Stripe::Customer.create  email: email,
                                        card: card_token

    Stripe::Charge.create  customer: customer.id,
                           amount: (amount * 100).to_i,
                           currency: 'usd',
                           receipt_email: customer.email
  end
end
