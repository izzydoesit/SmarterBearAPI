class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
  end
end
