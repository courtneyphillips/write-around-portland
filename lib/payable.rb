module Payable

  def process_payment
    customer = Stripe::Customer.create  email: email,
                                        card: card_token

    Stripe::Charge.create  customer: customer.id,
                            amount: self.amount.to_i * 100,
                            currency: 'usd',
                            receipt_email: customer.email
  end
end
