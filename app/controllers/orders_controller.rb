class OrdersController < ApplicationController


  def new
    @order = build_order
    @order.calculate_total
  end

  def create
    @order = build_order(stripe_params)
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
  def build_order(params = nil)
    if params
      order = Order.new(email: params[:stripeEmail], card_token: params[:stripeToken])
    else
      order = Order.new
    end
    cart_items = session[:cart]
    cart_items.each do |i|
      order.publications.push(Publication.find(i))
    end
    order
  end

  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end

end
