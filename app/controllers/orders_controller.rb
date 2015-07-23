class OrdersController < ApplicationController


  def new
    @order_publications = Publication.find(session[:cart])
    @total = @order_publications.map(&:price).reduce(:+)
  end

  def create
    @order = Order.new(email: stripe_params[:stripeEmail], card_token: stripe_params[:stripeToken])
    @order.add_items(publications_params)
    @order.calculate_total
    @order.process_payment
    @order.save
    session[:cart] = []
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update_cart
    if session[:cart]
      session[:cart] << params[:publication_id]
    else
      session[:cart] = [params[:publication_id]]
    end

    redirect_to publications_path, notice: "Item successfully added to cart."
  end

  private
  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end

  def publications_params
    params.select {|key, value| key.to_i.to_s == key }
  end
end
