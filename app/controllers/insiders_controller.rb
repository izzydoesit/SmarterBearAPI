class InsidersController < ApplicationController
  def index
    @insiders = Insider.all
    render :json => @insiders
  end

  def show
    @insider = Insider.find(params[:id])
    @insider_data = [@insider, @insider.transactions]
  end
end
