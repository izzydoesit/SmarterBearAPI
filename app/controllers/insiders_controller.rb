class InsidersController < ApplicationController
  def index
    @insdiders = Insider.all
    render :json => @insiders
  end
end
