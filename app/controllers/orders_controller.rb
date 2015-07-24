class OrdersController < ApplicationController


  def new
    @order = Order.new
    @order.add_items(session[:cart])
    @order.update_total
  end

  def create
    @order = Order.new(email: stripe_params[:stripeEmail], card_token: stripe_params[:stripeToken])
    @order.add_items(session[:cart])
    @order.update_total
    @order.process_payment
    @order.save
    session[:cart] = {}
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update_cart
    respond_to do |format|
      format.html do
        # session[:cart][params[:publication_id]] = 1
        set_quantity_in_cart(params[:publication_id], 1)
        redirect_to publications_path, notice: "Item successfully added to cart."
      end

      format.json do
        publication_id = params[:publication_id]
        quantity       = params[:quantity]
        set_quantity_in_cart(publication_id, quantity)
        @new_total = calculate_cart_total
        render :json => { total: @new_total }.to_json
      end
    end
  end

  private
  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end

  def set_quantity_in_cart(publication_id, quantity)
    session[:cart][publication_id] = quantity
  end

  def calculate_cart_total
    session[:cart].map { |publication_id, quantity|
      Publication.price(publication_id) * quantity.to_i }
                  .reduce(:+)
  end

  # def publications_params
  #   params.select {|key, value| key.to_i.to_s == key }
  # end

end
