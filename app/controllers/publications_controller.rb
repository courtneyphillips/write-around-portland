class PublicationsController < ApplicationController

  def index
    @publications = Publication.all
    if session[:cart] == nil
      session[:cart] = []
    end
    @cart_count = session[:cart].length
  end

  def show
    @publication = Publication.find(params[:id])
  end


end
