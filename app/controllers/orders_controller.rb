class OrdersController < ApplicationController


  def new
    @order = Order.new
    @order.add_items(session[:cart])
    @order.save
    # @order_publications = Publication.find(session[:cart].keys)
    # @total = @order_publications.map(&:price).reduce(:+)
  end

  def create
    @order = Order.new(email: stripe_params[:stripeEmail], card_token: stripe_params[:stripeToken])
    @order.add_items(session[:cart])
    @order.calculate_total
    @order.process_payment
    @order.save
    session[:cart] = {}
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update

  end

  def update_cart
    session[:cart][params[:publication_id]] = 1

    redirect_to publications_path, notice: "Item successfully added to cart."
  end

  private
  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end

  # def publications_params
  #   params.select {|key, value| key.to_i.to_s == key }
  # end

end
