class DonationsController < ApplicationController

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params.merge(email: stripe_params[:stripeEmail],
                                                   card_token: stripe_params[:stripeToken]))
    @donation.process_payment
    @donation.save
    redirect_to donation_path(@donation), notice: 'Donation successfully made!'
  end

  def show
    @donation = Donation.find(params[:id])
  end

  private
  def donation_params
    params.require(:donation).permit(:name, :phone_number, :amount)
  end

  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end
end
