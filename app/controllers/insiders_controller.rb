class InsidersController < ApplicationController
  def index
    @insiders = Insider.all
    render :json => @insiders
  end

  def show
  end
end
