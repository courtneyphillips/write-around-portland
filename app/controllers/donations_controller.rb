class DonationsController < ApplicationController

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.process_payment
    @donation.save
    redirect_to donation_path(@donation), notice: 'Thank you for your donation!'
  end

  def show
    @donation = Donation.find(params[:id])
  end

  private
  def donation_params
    params.require(:donation).permit(:name, :phone_number, :amount, :email, :card_token)
  end
end
