class PublicationsController < ApplicationController

  def index
    @publications = Publication.all
    session[:cart] = {} unless session[:cart]
    @cart_count = session[:cart].length
  end

  def show
    @publication = Publication.find(params[:id])
  end


end
