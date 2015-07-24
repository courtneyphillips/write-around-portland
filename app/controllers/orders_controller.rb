class OrdersController < ApplicationController


  def new
    @order = Order.new
    @order.add_items(session[:cart])
    @order.update_total
  end

  def create
    @order = Order.new(stripe_params)
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
        set_quantity_in_cart(params[:publication_id], 1)
        redirect_to publications_path, notice: "Item successfully added to cart."
      end

      format.json do
        set_quantity_in_cart(params[:publication_id], params[:quantity])
        render :json => { total: format_money(calculate_cart_total) }.to_json
      end
    end
  end

  private
  def stripe_params
    params.permit(:email, :card_token)
  end

  def set_quantity_in_cart(publication_id, quantity)
    session[:cart][publication_id] = quantity
  end

  def calculate_cart_total
    session[:cart].map { |publication_id, quantity|
      Publication.price(publication_id) * quantity.to_i }
                  .reduce(:+)
  end
end
